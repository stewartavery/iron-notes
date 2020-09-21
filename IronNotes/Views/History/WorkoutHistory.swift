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
  
  var body: some View {
    VStack(alignment: .leading, spacing: 0) {
      HStack {
        Text(getMonthAndYear(components))
          .font(.headline)
          .padding(.vertical, 10)
        Spacer()
      }.background(Color.white)
      
      Divider()
    }
  }
  
  
  private func getMonthAndYear(_ components: DateComponents) -> String {
    guard let month = components.month else {
      return ""
    }

    guard let year = components.year else {
      return ""
    }

    // TODO: consider locale
    let formatter = DateFormatter()
    let monthName = formatter.monthSymbols[month - 1]

    return "\(monthName) \(String(year))"
  }
}

struct WorkoutHistory: View {
  var groupedWorkouts: [DateComponents : [Workout]]
  
  var body: some View {
    NavigationView {
      ScrollView {
        LazyVStack(alignment: .leading, spacing: 10, pinnedViews: [.sectionHeaders]) {
          ForEach(Array(groupedWorkouts.keys), id: \.self) { key in
            Section(header: DateHeader(components: key)) {
              ForEach(groupedWorkouts[key] ?? []) { workout in
                VStack(alignment: .leading) {
                  HStack {
                    VStack(alignment: .leading) {
                      Text(workout.meta.name).font(.headline)
                      Text(workout.readableDate)
                    }
                  }
                }
                
              }
            }
          }
        }
        .padding()
      }
      
      .navigationBarTitle("History")
    }
  }
  
}

//struct WorkoutHistory_Previews: PreviewProvider {
//  static var previews: some View {
//    WorkoutHistory(workouts: IronNotesModelFactory.getWorkouts())
//
//  }
//}
