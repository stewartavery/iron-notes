//
//  ExerciseTemplate+CoreDataProperties.swift
//  IronNotes
//
//  Created by Stewart Avery on 5/23/20.
//  Copyright © 2020 Stewart Avery. All rights reserved.
//
//

import Foundation
import CoreData


extension ExerciseTemplate {
  
  @nonobjc public class func fetchRequest() -> NSFetchRequest<ExerciseTemplate> {
    return NSFetchRequest<ExerciseTemplate>(entityName: "ExerciseTemplate")
  }
  
  @NSManaged public var desc: String
  @NSManaged public var exerciseType: String
  @NSManaged public var name: String
  @NSManaged public var muscleGroups: NSSet?
  @NSManaged public var exercises: NSSet?
  
  
}

// MARK: Generated accessors for muscleGroups
extension ExerciseTemplate {
  @objc(addMuscleGroupsObject:)
  @NSManaged public func addToMuscleGroups(_ value: MuscleGroup)
  
  @objc(removeMuscleGroupsObject:)
  @NSManaged public func removeFromMuscleGroups(_ value: MuscleGroup)
  
  @objc(addMuscleGroups:)
  @NSManaged public func addToMuscleGroups(_ values: NSSet)
  
  @objc(removeMuscleGroups:)
  @NSManaged public func removeFromMuscleGroups(_ values: NSSet)
  
}


// MARK: Generated accessors for exercises
extension ExerciseTemplate {
  
  @objc(addExercisesObject:)
  @NSManaged public func addToExercises(_ value: Exercise)
  
  @objc(removeExercisesObject:)
  @NSManaged public func removeFromExercises(_ value: Exercise)
  
  @objc(addExercises:)
  @NSManaged public func addToExercises(_ values: NSSet)
  
  @objc(removeExercises:)
  @NSManaged public func removeFromExercises(_ values: NSSet)
  
}
