//
//  ActiveWorkout.swift
//  IronNotes
//
//  Created by Stewart Avery on 2/16/20.
//  Copyright © 2020 Stewart Avery. All rights reserved.
//

import SwiftUI
import CoreData
import Combine


enum WorkoutSheet: String, Identifiable {
  var id: String {
    return rawValue
  }
  
  case workout, exercises
}

enum ScrollDirection: Equatable {
  case none
  case up(CGFloat)
  case down(CGFloat)
}

struct ActiveWorkoutEditor: View {
  @Environment(\.scenePhase) private var scenePhase
  
  @StateObject var stopwatchManager = StopwatchManager()
  @StateObject var cardDetails = CardDetails()
  
  @ObservedObject var keyboardMonitor: KeyboardMonitor
  @ObservedObject var activeWorkout: ActiveWorkout
  
  @State var workoutSheet: WorkoutSheet? = nil
  
  var body: some View {
    return ZStack {
      ExerciseCardList(workoutSheet: $workoutSheet)
      
      DelayedSlideOverCard(workoutSheet: $workoutSheet)
        .environmentObject(stopwatchManager)
    }
    .onAppear {
      resumeTimer()
    }
    .environmentObject(activeWorkout)
    .environmentObject(keyboardMonitor)
    .environmentObject(cardDetails)
    .onChange(of: scenePhase) { phase in
      switch phase {
      case .active:
        resumeTimer()
        break
      default:
        break
      }
    }
    .onChange(of: workoutSheet) { _ in
      cardDetails.position = .bottom
    }
  }
  
  func resumeTimer() {
    if let startTime = activeWorkout.workout.startTime {
      stopwatchManager.resumeFromBackground(startTime: startTime)
    }
  }
}

#if DEBUG
struct ActiveWorkoutEditor_Previews: PreviewProvider {
  static var previews: some View {
    ActiveWorkoutEditor(
      keyboardMonitor: KeyboardMonitor(),
      activeWorkout: ActiveWorkout.pendingWorkout
    )
    .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
    .environmentObject(IronNotesModelFactory.getWorkout())
  }
}
#endif


