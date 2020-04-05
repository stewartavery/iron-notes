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


public class Exercise: NSManagedObject {%
  class func newExercise() -> Exercise {
    return Exercise(context: AppDelegate.viewContext)
  }
  
  class func createExerciseFor(name: String, desc: String, muscleGroup: MuscleGroup, exerciseType: ExerciseType) -> Void {
    let exercise = Exercise.newExercise()
    exercise.name = name
    exercise.desc = desc
    exercise.muscleGroup = muscleGroup.rawValue
    exercise.exerciseType = exerciseType.rawValue
    try! AppDelegate.viewContext.save()
  }
}
