//
//  WorkoutHistory.swift
//  IronNotes
//
//  Created by Stewart Avery on 9/2/20.
//  Copyright © 2020 Stewart Avery. All rights reserved.
//

import SwiftUI

struct WorkoutHistory: View {
  var groupedWorkouts: [DateComponents : [Workout]]
  
  var body: some View {
    print(Array(groupedWorkouts.keys))
    return NavigationView {
      ScrollView {
        LazyVStack(spacing: 10) {
          
          ForEach(Array(groupedWorkouts.keys), id: \.self) { key in
            Section(header: Text(getMonthAndYear(key))) {
              Text("hey")
//              ForEach(workouts) { workout in
//                VStack(alignment: .leading) {
//                  HStack {
//                    VStack(alignment: .leading) {
//                      Text(workout.meta.name).font(.headline)
//                      Text(workout.readableDate)
//
//                    }
//                  }
//                }
              
            }
          }
          .padding()
        }
      }
      
      .navigationBarTitle("History")
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
    
    return monthName + String(year)
  }
}

//struct WorkoutHistory_Previews: PreviewProvider {
//  static var previews: some View {
//    WorkoutHistory(workouts: IronNotesModelFactory.getWorkouts())
//
//  }
//}
