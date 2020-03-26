//
//  ExerciseType.swift
//  IronNotes
//
//  Created by Stewart Avery on 2/16/20.
//  Copyright © 2020 Stewart Avery. All rights reserved.
//

import SwiftUI

enum ExerciseType: Int {
  case barbell, dumbbell, machine
  
  var description: String {
      switch self {
      case .barbell:
          return "Barbell"
      case .dumbbell:
          return "Dumbbell"
      case .machine:
          return "Machine"
      }
  }
  
  // rewrite this to make it a caseIterable

  static func initialize(stringValue: String)-> ExerciseType? {
      switch stringValue {
      case ExerciseType.barbell.description:
          return ExerciseType.barbell
      case ExerciseType.dumbbell.description:
          return ExerciseType.dumbbell
      case ExerciseType.machine.description:
          return ExerciseType.machine

      default:
          return nil
      }
  }
}


