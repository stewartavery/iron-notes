//
//  WorkoutHistoryRow.swift
//  IronNotes
//
//  Created by Stewart Avery on 11/29/20.
//  Copyright © 2020 Stewart Avery. All rights reserved.
//

import SwiftUI

struct WorkoutHistoryRow: View {
  var workout: Workout
  
  init(_ workout: Workout) {
    self.workout = workout
  }
  
  var body: some View {
    NavigationLink(destination:  WorkoutHistoryDetail(workout: workout)) {
      SummaryRow(
        title: workout.meta?.wrappedName ?? "Untitled",
        description: workout.readableDate,
        color: .blue
      )
    }
  }
}
