//
//  WorkoutHistory.swift
//  IronNotes
//
//  Created by Stewart Avery on 9/2/20.
//  Copyright © 2020 Stewart Avery. All rights reserved.
//

import SwiftUI

struct DateHeader: View {
  var components: DateComponents
  var itemCount: Int
  
  @Environment(\.colorScheme) var colorScheme: ColorScheme
  
  var body: some View {
    VStack(alignment: .leading, spacing: 0) {
      HStack {
        Text(getMonthAndYear(components))
          .padding(.vertical, 10)
        Spacer()
        Text("Total: \(String(itemCount))" )
      }
      .padding(.horizontal, 20)
      .font(.headline)
      .background(colorScheme == .light ? Color.white : Color.black)
      
      if colorScheme == .light {
        Divider()
      }
      
    }
  }
  
  
  private func getMonthAndYear(_ components: DateComponents) -> String {
    guard let month = components.month else { return "" }
    guard let year = components.year else { return "" }
    
    // TODO: consider locale
    let formatter = DateFormatter()
    let monthName = formatter.monthSymbols[month - 1]
    
    return "\(monthName) \(String(year))"
  }
}

struct WorkoutHistory: View {
  @Environment(\.colorScheme) var colorScheme: ColorScheme
  var groupedWorkouts: [DateComponents : [Workout]]
  
  var body: some View {
    NavigationView {
      ZStack {
        switch colorScheme {
        case .light:
          Color(UIColor.systemGray6).edgesIgnoringSafeArea(.all)
        case .dark:
          Color.black.edgesIgnoringSafeArea(.all)
        @unknown default:
          Color(UIColor.systemGray6).edgesIgnoringSafeArea(.all)
        }
        
        VStack {
          ScrollView {
            LazyVStack(alignment: .leading, spacing: 5, pinnedViews: [.sectionHeaders]) {
              ForEach(Array(groupedWorkouts.keys), id: \.self) { key in
                if let workouts = groupedWorkouts[key] {
                  Section(header: DateHeader(components: key, itemCount: workouts.count)) {
                    ForEach(workouts) { workout in
                      NavigationLink(destination: WorkoutHistoryDetail(workout: workout)) {
                        WorkoutHistoryRow(workout: workout)
                          .accentColor(colorScheme == .light ? Color.black : Color.white)
                      }
                      .padding(.horizontal, 20)
                    }
                  }
                }
              }
            }
          }
        }
      }
      .navigationBarTitle("History")
    }
  }
  
}

struct WorkoutHistory_Previews: PreviewProvider {
  static var groupedWorkouts: [DateComponents : [Workout]] {
    return Dictionary.init(grouping: IronNotesModelFactory.getWorkouts()) {
      return Calendar.current.dateComponents([.month, .year], from: ($0.startTime)!)
    }
  }
  
  static var previews: some View {
    Group {
      WorkoutHistory(groupedWorkouts: groupedWorkouts)
      WorkoutHistory(groupedWorkouts: groupedWorkouts)
        .environment(\.colorScheme, .dark)
    }
    
  }
}
