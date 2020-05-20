//
//  Exercise+CoreDataClass.swift
//  IronNotes
//
//  Created by Stewart Avery on 5/19/20.
//  Copyright © 2020 Stewart Avery. All rights reserved.
//
//

import Foundation
import CoreData


public class Exercise: NSManagedObject {
    class func newExercise() -> Exercise {
      return Exercise(context: AppDelegate.viewContext)
    }
    
    class func createExerciseFor(name: String, desc: String, muscleGroups: [MuscleGroup], exerciseType: ExerciseType) -> Void {
      let exercise = Exercise.newExercise()
      
      print("For exercise: \(name)")
      exercise.name = name
      exercise.desc = desc
      
      let orderedSet = NSOrderedSet(array: muscleGroups)

      exercise.muscleGroups = orderedSet
      exercise.exerciseType = exerciseType.rawValue
      try! AppDelegate.viewContext.save()
    }

}
