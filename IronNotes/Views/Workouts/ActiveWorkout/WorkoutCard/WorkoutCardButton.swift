//
//  WorkoutCardButton.swift
//  IronNotes
//
//  Created by Stewart Avery on 8/29/20.
//  Copyright © 2020 Stewart Avery. All rights reserved.
//

import SwiftUI

struct WorkoutCardButton: View {
  @EnvironmentObject var stopwatchManager: StopwatchManager
  @EnvironmentObject var workout: Workout
  @EnvironmentObject var workoutStore: WorkoutStore
  @Environment(\.presentationMode) var presentationMode
  
  var body: some View {
    switch stopwatchManager.mode {
    case .running:
      Button("Stop", action: stopWorkout)
        .buttonStyle(WorkoutStopStyle())
    case .stopped:
      Button("Start", action: startWorkout)
        .buttonStyle(WorkoutStartStyle())
    }
  }
  
  private func stopWorkout() {
    workout.duration = Int16(stopwatchManager.secondsElapsed)
    stopwatchManager.stop()
    workoutStore.workoutStatus = .stopped
    presentationMode.wrappedValue.dismiss()
  }
  
  private func startWorkout() {
    workout.startTime = Date()
    stopwatchManager.start()
    workoutStore.workoutStatus = .running
  }
}

struct CurrentRunningTime: View {
  @EnvironmentObject var stopwatchManager: StopwatchManager
  
  var body: some View {
    Group {
      switch stopwatchManager.mode {
      case .running:
        Text((stopwatchManager.secondsElapsed.asString(style: .positional)))
      case .stopped:
        Text("Not started")
      }
    }
    .foregroundColor(Color.gray)
  }
}

#if DEBUG
struct WorkoutCardButton_Previews: PreviewProvider {
  @State static var workoutStatus: WorkoutStatus = .stopped
  static var previews: some View {
    Group {
      WorkoutCardButton()
        .environmentObject(StopwatchManager())
        .environmentObject(WorkoutStore(managedObjectContext: PersistenceController.shared.container.viewContext))
      WorkoutCardButton()
        .environment(\.sizeCategory, .extraExtraExtraLarge)
        .environmentObject(StopwatchManager())
        .environmentObject(WorkoutStore(managedObjectContext: PersistenceController.shared.container.viewContext))
    }
  }
}
#endif
