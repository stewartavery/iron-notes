//
//  Exercise+CoreDataProperties.swift
//  IronNotes
//
//  Created by Stewart Avery on 5/23/20.
//  Copyright © 2020 Stewart Avery. All rights reserved.
//
//

import Foundation
import CoreData


extension Exercise {
  
  @nonobjc public class func fetchRequest() -> NSFetchRequest<Exercise> {
    return NSFetchRequest<Exercise>(entityName: "Exercise")
  }
  
  @NSManaged public var meta: ExerciseTemplate
  @NSManaged public var note: String
  @NSManaged public var position: Int16
  @NSManaged public var sets: NSSet?
  @NSManaged public var workout: Workout?

  public var exerciseSetArray: [ExerciseSet] {
    let set = sets as? Set<ExerciseSet> ?? []
    
    return set.sorted {
      $0.setPosition > $1.setPosition
    }
  }
  
}

// MARK: Generated accessors for sets
extension Exercise {
  
  @objc(addSetsObject:)
  @NSManaged public func addToSets(_ value: ExerciseSet)
  
  @objc(removeSetsObject:)
  @NSManaged public func removeFromSets(_ value: ExerciseSet)
  
  @objc(addSets:)
  @NSManaged public func addToSets(_ values: NSSet)
  
  @objc(removeSets:)
  @NSManaged public func removeFromSets(_ values: NSSet)
  
}
