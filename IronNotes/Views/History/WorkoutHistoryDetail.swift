//
//  WorkoutHistoryDetail.swift
//  IronNotes
//
//  Created by Stewart Avery on 9/25/20.
//  Copyright © 2020 Stewart Avery. All rights reserved.
//

import SwiftUI

struct WorkoutHistoryDetail: View {
  var workout: Workout
  
  var body: some View {
    List {
      ForEach(workout.routinesArray) { exercise in
        Section {
          ExerciseCard(exercise: exercise, isActive: false, isOnlyTitleVisible: false)
        }
      }
      .listStyle(InsetGroupedListStyle())
    }
    .navigationBarTitle("History", displayMode: .inline)
  }
  
}

struct WorkoutHistoryDetail_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      WorkoutHistoryDetail(workout: IronNotesModelFactory.getWorkout())
    }
  }
}
