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

struct ActiveWorkout: View {
  
  @ObservedObject var keyboardMonitor: KeyboardMonitor
  @ObservedObject var workout: Workout
  @ObservedObject var workoutStore: WorkoutStore
  
  @State private var workoutSheet: WorkoutSheet? = nil
  
  var body: some View {
    ExerciseCardList(workoutSheet: $workoutSheet)
      .environmentObject(keyboardMonitor)
      .environmentObject(workout)
      .environmentObject(workoutStore)
  }
}

#if DEBUG
struct ActiveWorkout_Previews: PreviewProvider {
  @State static var workoutStatus: WorkoutStatus = .stopped
  static var previews: some View {
    ActiveWorkout(
      keyboardMonitor: KeyboardMonitor(),
      workout: IronNotesModelFactory.getWorkout(),
      workoutStore: WorkoutStore(managedObjectContext: PersistenceController.shared.container.viewContext)
    )
    .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
    .environmentObject(IronNotesModelFactory.getWorkout())
  }
}
#endif


