//
//  ExerciseSet+CoreDataClass.swift
//  IronNotes
//
//  Created by Stewart Avery on 3/2/20.
//  Copyright © 2020 Stewart Avery. All rights reserved.
//
//

import Foundation
import CoreData


public class ExerciseSet: NSManagedObject {
  class func newExerciseSet() -> ExerciseSet {
    let set = ExerciseSet(context: PersistenceController.shared.container.viewContext)
    set.id = UUID()
    return set
  }
  
  class func getExerciseSet(setPosition: Int, reps: Int, weight: Int, exercise: Exercise, isCompleted: Bool) -> ExerciseSet {
    let exerciseSet = newExerciseSet()
    exerciseSet.setPosition = Int16(setPosition)
    exerciseSet.reps = Int16(reps)
    exerciseSet.weight = Int32(weight)
    exerciseSet.exercise = exercise
    exerciseSet.isCompleted = isCompleted
    
    return exerciseSet
  }
}
