//
//  Exercise+CoreDataClass.swift
//  IronNotes
//
//  Created by Stewart Avery on 5/23/20.
//  Copyright © 2020 Stewart Avery. All rights reserved.
//
//

import Foundation
import CoreData


public class Exercise: NSManagedObject {
  class func newExercise() -> Exercise {
    return Exercise(context: AppDelegate.viewContext)
  }

  class func getExercise(meta: ExerciseTemplate, note: String, position: Int16, sets: [ExerciseSet], workout: Workout) -> Exercise {
    let exercise = newExercise()
    exercise.meta = meta
    exercise.note = note
    exercise.position = position
    exercise.sets = NSSet(array: sets)
    exercise.workout = workout
    
    return exercise
  }
  
}
