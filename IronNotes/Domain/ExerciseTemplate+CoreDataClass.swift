//
//  ExerciseTemplate+CoreDataClass.swift
//  IronNotes
//
//  Created by Stewart Avery on 5/23/20.
//  Copyright © 2020 Stewart Avery. All rights reserved.
//
//

import Foundation
import CoreData


public class ExerciseTemplate: NSManagedObject {
  class func newExerciseTemplate() -> ExerciseTemplate {
      return ExerciseTemplate(context: AppDelegate.viewContext)
    }
    
    class func createExerciseTemplateFor(name: String, desc: String, muscleGroups: [MuscleGroup], exerciseType: ExerciseType) -> Void {
      let exercise = Exercise.newExercise()
      exercise.name = name
      exercise.desc = desc
      exercise.muscleGroup = muscleGroups
      exercise.exerciseType = exerciseType.rawValue
      try! AppDelegate.viewContext.save()
    }
}
