//
//  ExerciseType.swift
//  IronNotes
//
//  Created by Stewart Avery on 2/16/20.
//  Copyright © 2020 Stewart Avery. All rights reserved.
//

import SwiftUI

enum ExerciseType: String, CaseIterable, Identifiable {
  case barbell = "Barbell"
  case dumbbell = "Dumbbell"
  case machine = "Machine"
  case bodyweight = "Bodyweight"
  
  var id: String {
    return self.rawValue
  }
}
