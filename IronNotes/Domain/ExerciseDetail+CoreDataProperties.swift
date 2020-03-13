//
//  ExerciseDetail+CoreDataProperties.swift
//  IronNotes
//
//  Created by Stewart Avery on 3/3/20.
//  Copyright © 2020 Stewart Avery. All rights reserved.
//
//

import Foundation
import CoreData


extension ExerciseDetail {
  
  @nonobjc public class func fetchRequest() -> NSFetchRequest<ExerciseDetail> {
    return NSFetchRequest<ExerciseDetail>(entityName: "ExerciseDetail")
  }
  
  @NSManaged public var exerciseDetailId: UUID?
  @NSManaged public var sets: NSSet?
  @NSManaged public var workout: Workout?
  @NSManaged public var exerciseDetailIndex: Int16
  
  public var exerciseSetArray: [ExerciseSet] {
    let set = sets as? Set<ExerciseSet> ?? []
    
    return set.sorted {
      $0.exerciseSetIndex > $1.exerciseSetIndex
    }
  }
  
}

// MARK: Generated accessors for sets
extension ExerciseDetail {
  
  @objc(addSetsObject:)
  @NSManaged public func addToSets(_ value: ExerciseSet)
  
  @objc(removeSetsObject:)
  @NSManaged public func removeFromSets(_ value: ExerciseSet)
  
  @objc(addSets:)
  @NSManaged public func addToSets(_ values: NSSet)
  
  @objc(removeSets:)
  @NSManaged public func removeFromSets(_ values: NSSet)
  
}
