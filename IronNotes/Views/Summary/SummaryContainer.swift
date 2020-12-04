//
//  SummaryContainer.swift
//  IronNotes
//
//  Created by Stewart Avery on 11/29/20.
//  Copyright © 2020 Stewart Avery. All rights reserved.
//

import SwiftUI

struct SummaryContainer: View {
  @EnvironmentObject var workoutStore: WorkoutStore
  @EnvironmentObject var keyboardMonitor: KeyboardMonitor
  @Environment(\.scenePhase) private var scenePhase

  var templates: [WorkoutTemplate] {
    return Array(workoutStore.workoutTemplates.prefix(3))
  }
  
  var workouts: [Workout] {
    return Array(workoutStore.workouts.prefix(3))
  }
  
  var body: some View {
    SummaryView(
      templates: templates,
      workouts: workouts
    ).fullScreenCover(
      item: $workoutStore.workoutInput,
      onDismiss: workoutStore.finishWorkout) { _ in
      switch workoutStore.activeWorkout {
      case .some(let activeWorkout):
        ActiveWorkoutEditor(
          keyboardMonitor: keyboardMonitor,
          activeWorkout: activeWorkout
        ).environment(\.scenePhase, scenePhase)
      case .none:
        EmptyView()
      }
    }
  }
}
