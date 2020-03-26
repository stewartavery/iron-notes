//
//  Exercise+CoreDataClass.swift
//  IronNotes
//
//  Created by Stewart Avery on 3/2/20.
//  Copyright © 2020 Stewart Avery. All rights reserved.
//
//

import Foundation
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
  
  var muscleGroup: MuscleGroup {
      get {
        return MuscleGroup(rawValue: Int(self.muscleGroupValue)) ?? .abdominals
      }
      set {
          self.muscleGroupValue = Int16(newValue.rawValue)
      }
  }
}
