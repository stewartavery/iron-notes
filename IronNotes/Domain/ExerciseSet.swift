//
//  ExerciseSet.swift
//  IronNotes
//
//  Created by Stewart Avery on 2/16/20.
//  Copyright © 2020 Stewart Avery. All rights reserved.
//

import SwiftUI

struct ExerciseSet: Identifiable, Codable {
  var id: Int
  var weight: Int
  var reps: Int
  
  mutating func modifySet(newWeight: Int, newReps: Int) {
    self.weight = newWeight
    self.reps = newReps
  }
}
