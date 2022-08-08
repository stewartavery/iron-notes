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
    @EnvironmentObject var activeWorkout: ActiveWorkout
    @Environment(\.dismiss) private var dismiss

    
    var body: some View {
        switch stopwatchManager.mode {
        case .running:
            Button("Stop") {
                stopWorkout(with: activeWorkout.workout)
            }.buttonStyle(WorkoutStopStyle())
        case .stopped:
            Button("Start") {
                startWorkout(with: activeWorkout.workout)
            }.buttonStyle(WorkoutStartStyle())
            
        }
    }
    
    private func stopWorkout(with workout: Workout) {
        workout.duration = Int16(stopwatchManager.secondsElapsed)
        stopwatchManager.stop()
        activeWorkout.status = .finished
        dismiss()
    }
    
    private func startWorkout(with workout: Workout) {
        workout.startTime = Date()
        stopwatchManager.start()
        activeWorkout.status = .running
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
    static var previews: some View {
        WorkoutCardButton()
            .environmentObject(StopwatchManager())
            .environmentObject(ActiveWorkout.pendingWorkout)
    }
}
#endif
