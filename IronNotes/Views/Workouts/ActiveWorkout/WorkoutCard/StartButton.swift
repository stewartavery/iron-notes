//
//  StartButton.swift
//  IronNotes
//
//  Created by Stewart Avery on 8/29/20.
//  Copyright © 2020 Stewart Avery. All rights reserved.
//

import SwiftUI

struct BottomBarContent: View {
  @EnvironmentObject var stopwatchManager: StopwatchManager
  @EnvironmentObject var workout: Workout
  @EnvironmentObject var workoutStore: WorkoutStore
  @Environment(\.presentationMode) var presentationMode
  
  var body: some View {
    switch stopwatchManager.mode {
    case .running:
      Button {
        workout.duration = Int16(stopwatchManager.secondsElapsed)
        stopwatchManager.stop()
        workoutStore.workoutStatus = .stopped
        presentationMode.wrappedValue.dismiss()
      } label: {
        Image(systemName: "stop.fill")
      }
    case .stopped:
      Text("")
    }
  }
}

struct StatusContent: View {
  @EnvironmentObject var stopwatchManager: StopwatchManager
  
  var body: some View {
    switch stopwatchManager.mode {
    case .running:
      Text((stopwatchManager.secondsElapsed.asString(style: .positional)))
        .fontWeight(.bold)
        .font(.title)
    case .stopped:
      Text("")
    }
  }
}


struct StartButton: View {
  @EnvironmentObject var stopwatchManager: StopwatchManager
  @EnvironmentObject var workout: Workout
  @EnvironmentObject var workoutStore: WorkoutStore
  
  var body: some View {
    Text("Start")
      .fontWeight(.bold)
      .frame(maxWidth: .infinity)
      .padding()
      .background(Color.orange)
      .font(.headline)
      .cornerRadius(10)
      .foregroundColor(Color.white)
      .onTapGesture {
        workout.startTime = Date()
        stopwatchManager.start()
        workoutStore.workoutStatus = .running
      }
  }
}


#if DEBUG
struct StartButton_Previews: PreviewProvider {
  @State static var workoutStatus: WorkoutStatus = .stopped
  static var previews: some View {
    StartButton()
      .environmentObject(StopwatchManager())
      .environmentObject(WorkoutStore(managedObjectContext: PersistenceController.shared.container.viewContext))
  }
}
#endif
