//
//  ExerciseDetail.swift
//  IronNotes
//
//  Created by Stewart Avery on 2/16/20.
//  Copyright © 2020 Stewart Avery. All rights reserved.
//

import SwiftUI
import CoreData

public class Exercise: NSManagedObject {
  var exerciseType: ExerciseType {
      get {
        return ExerciseType(rawValue: Int(self.exerciseTypeValue)) ?? .barbell
      }
      set {
          self.exerciseTypeValue = Int16(newValue.rawValue)
      }
  }
}
