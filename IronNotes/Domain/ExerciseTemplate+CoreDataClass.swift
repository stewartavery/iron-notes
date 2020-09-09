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
    return ExerciseTemplate(context: PersistenceController.shared.container.viewContext)
  }
  
  class func createExerciseTemplateFor(name: String, desc: String, muscleGroups: [MuscleGroup], exerciseType: ExerciseType, workoutTemplates: [WorkoutTemplate] = []) -> Void {
    let exerciseTemplate = newExerciseTemplate()
    exerciseTemplate.name = name
    exerciseTemplate.desc = desc
    exerciseTemplate.muscleGroups = NSSet(array: muscleGroups)
    exerciseTemplate.exerciseType = exerciseType.rawValue
    exerciseTemplate.workoutTemplates = NSSet(array: workoutTemplates)
    try! PersistenceController.shared.container.viewContext.save()
  }
}
