//
//  SummaryView.swift
//  IronNotes
//
//  Created by Stewart Avery on 11/16/20.
//  Copyright © 2020 Stewart Avery. All rights reserved.
//

import SwiftUI

struct SummaryView: View {
  var templates: [WorkoutTemplate]
  var workouts: [Workout]
  
  var workoutsHeader: some View {
    SummaryHeader("Workouts") {
      StartWorkoutList()
    }
  }
  
  var historyHeader: some View {
    SummaryHeader("History") {
      WorkoutHistoryContainer()
    }
  }
  
  var body: some View {
    NavigationView {
      ZStack {
        Color(.systemGroupedBackground)
          .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        
        ScrollView {
          LazyVStack {
            Section(header: workoutsHeader) {
              ForEach(templates) { template in
                StartWorkoutButton(template: template)
              }
            }
            
            if (workouts.count > 0) {
              Section(header: historyHeader) {
                ForEach(workouts) { workout in
                  WorkoutHistoryRow(workout)
                }
              }
            }
          }
          .padding(.horizontal)
        }
      }
      .navigationTitle("Summary")
    }
  }
}



struct SummaryView_Previews: PreviewProvider {
  static var previews: some View {
    SummaryView(
      templates: Array(IronNotesModelFactory.getWorkoutTemplates().prefix(3)),
      workouts: Array(IronNotesModelFactory.getWorkouts().prefix(3)))
  }
}

