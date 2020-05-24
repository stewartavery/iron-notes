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
  @NSManaged public var muscleGroups: NSOrderedSet?
  
}

// MARK: Generated accessors for muscleGroups
extension ExerciseTemplate {
  
  @objc(insertObject:inMuscleGroupsAtIndex:)
  @NSManaged public func insertIntoMuscleGroups(_ value: MuscleGroup, at idx: Int)
  
  @objc(removeObjectFromMuscleGroupsAtIndex:)
  @NSManaged public func removeFromMuscleGroups(at idx: Int)
  
  @objc(insertMuscleGroups:atIndexes:)
  @NSManaged public func insertIntoMuscleGroups(_ values: [MuscleGroup], at indexes: NSIndexSet)
  
  @objc(removeMuscleGroupsAtIndexes:)
  @NSManaged public func removeFromMuscleGroups(at indexes: NSIndexSet)
  
  @objc(replaceObjectInMuscleGroupsAtIndex:withObject:)
  @NSManaged public func replaceMuscleGroups(at idx: Int, with value: MuscleGroup)
  
  @objc(replaceMuscleGroupsAtIndexes:withMuscleGroups:)
  @NSManaged public func replaceMuscleGroups(at indexes: NSIndexSet, with values: [MuscleGroup])
  
  @objc(addMuscleGroupsObject:)
  @NSManaged public func addToMuscleGroups(_ value: MuscleGroup)
  
  @objc(removeMuscleGroupsObject:)
  @NSManaged public func removeFromMuscleGroups(_ value: MuscleGroup)
  
  @objc(addMuscleGroups:)
  @NSManaged public func addToMuscleGroups(_ values: NSOrderedSet)
  
  @objc(removeMuscleGroups:)
  @NSManaged public func removeFromMuscleGroups(_ values: NSOrderedSet)
  
}
