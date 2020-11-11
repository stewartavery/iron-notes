//
//  ActiveWorkokut.swift
//  IronNotes
//
//  Created by Stewart Avery on 11/11/20.
//  Copyright © 2020 Stewart Avery. All rights reserved.
//

import SwiftUI

enum WorkoutStatus {
  case pending
  case running
  case finished
}

class ActiveWorkout: ObservableObject {
  @Published var workout: Workout
  @Published var status: WorkoutStatus = .pending
  
  init(_ workout: Workout) {
    self.workout = workout
  }
  
  init(workout: Workout, status: WorkoutStatus) {
    self.workout = workout
    self.status = status
  }
}

extension ActiveWorkout {
  static let pendingWorkout = ActiveWorkout(IronNotesModelFactory.getWorkout())
  
  static let runningWorkout = ActiveWorkout(
    workout: IronNotesModelFactory.getWorkout(),
    status: WorkoutStatus.running
  )
  
  static let finishedWorkout = ActiveWorkout(
    workout: IronNotesModelFactory.getWorkout(),
    status: WorkoutStatus.finished
  )
}

