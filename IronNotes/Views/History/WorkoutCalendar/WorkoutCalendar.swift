//
//  WorkoutCalendar.swift
//  IronNotes
//
//  Created by Stewart Avery on 10/1/20.
//  Copyright © 2020 Stewart Avery. All rights reserved.
//

import SwiftUI

fileprivate extension DateFormatter {
  static var month: DateFormatter {
    let formatter = DateFormatter()
    formatter.dateFormat = "MMMM"
    return formatter
  }
  
  static var monthAndYear: DateFormatter {
    let formatter = DateFormatter()
    formatter.dateFormat = "MMMM yyyy"
    return formatter
  }
}

fileprivate extension Calendar {
  func generateDates(
    inside interval: DateInterval,
    matching components: DateComponents
  ) -> [Date] {
    var dates: [Date] = []
    dates.append(interval.start)
    
    enumerateDates(
      startingAfter: interval.start,
      matching: components,
      matchingPolicy: .nextTime
    ) { date, _, stop in
      if let date = date {
        if date < interval.end {
          dates.append(date)
        } else {
          stop = true
        }
      }
    }
    
    return dates
  }
}

struct PagerView<Content: View>: View {
  let pageCount: Int
  @Binding var currentIndex: Int
  let content: Content
  
  @GestureState private var dragState = DragState.inactive
  
  init(pageCount: Int, currentIndex: Binding<Int>, @ViewBuilder content: () -> Content) {
    self.pageCount = pageCount
    self._currentIndex = currentIndex
    self.content = content()
  }
  
  var body: some View {
    GeometryReader { geometry in
      HStack(spacing: 0) {
        content.frame(width: geometry.size.width)
      }
      .frame(width: geometry.size.width, alignment: .leading)
      .offset(x: -CGFloat(currentIndex) * geometry.size.width)
      .offset(x: dragState.translation.width)
      .animation(self.dragState.isDragging ? nil : .interpolatingSpring(stiffness: 300.0, damping: 30.0, initialVelocity: 10.0))
      .gesture(
        DragGesture().updating($dragState) { value, state, _ in
          if value.predictedEndLocation.x - value.location.x > 0 {
            state = .left(translation: value.translation)
          } else {
            state = .right(translation: value.translation)
          }
        }.onEnded { value in
          let offset = value.translation.width / geometry.size.width
          let newIndex = (CGFloat(currentIndex) - offset).rounded()
          currentIndex = min(max(Int(newIndex), 0), pageCount - 1)
        }
      )
    }
  }
}

struct WorkoutCalendar<DateView>: View where DateView: View {
  @Environment(\.calendar) var calendar
  
  let interval: DateInterval
  let showHeaders: Bool
  let content: (Date) -> DateView
  
  @State private var currentPage = 0
  
  init(
    interval: DateInterval,
    showHeaders: Bool = true,
    @ViewBuilder content: @escaping (Date) -> DateView
  ) {
    self.interval = interval
    self.showHeaders = showHeaders
    self.content = content
  }
  
  var body: some View {
    PagerView(pageCount: months.count, currentIndex: $currentPage) {
      ForEach(months, id: \.self) { month in
        LazyVGrid(columns: Array(repeating: GridItem(), count: 6)) {
          ForEach(days(for: month), id: \.self) { date in
            if calendar.isDate(date, equalTo: month, toGranularity: .month) {
              content(date).id(date)
            } else {
              content(date).hidden()
            }
          }
          
        }
      }
    }.frame(height: 200)
  }
  
  private var months: [Date] {
    calendar.generateDates(
      inside: interval,
      matching: DateComponents(day: 1, hour: 0, minute: 0, second: 0)
    )
  }
  
  private func header(for month: Date) -> some View {
    let component = calendar.component(.month, from: month)
    let formatter = component == 1 ? DateFormatter.monthAndYear : .month
    
    return Group {
      if showHeaders {
        Text(formatter.string(from: month))
          .font(.title)
          .padding()
      }
    }
  }
  
  private func days(for month: Date) -> [Date] {
    guard
      let monthInterval = calendar.dateInterval(of: .month, for: month),
      let monthFirstWeek = calendar.dateInterval(of: .weekOfMonth, for: monthInterval.start),
      let monthLastWeek = calendar.dateInterval(of: .weekOfMonth, for: monthInterval.end)
    else { return [] }
    return calendar.generateDates(
      inside: DateInterval(start: monthFirstWeek.start, end: monthLastWeek.end),
      matching: DateComponents(hour: 0, minute: 0, second: 0)
    )
  }
}

struct WorkoutCalendar_Previews: PreviewProvider {
  static var previews: some View {
    WorkoutCalendar(interval: DateInterval(start: Date(), end: Date())) { _ in
      Text("30")
        .padding(8)
        .cornerRadius(8)
    }
  }
}

