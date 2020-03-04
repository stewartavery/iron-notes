//
//  Workout+CoreDataProperties.swift
//  IronNotes
//
//  Created by Stewart Avery on 3/3/20.
//  Copyright © 2020 Stewart Avery. All rights reserved.
//
//

import Foundation
import CoreData


extension Workout {
  
  @nonobjc public class func fetchRequest() -> NSFetchRequest<Workout> {
    return NSFetchRequest<Workout>(entityName: "Workout")
  }
  
  @NSManaged public var desc: String?
  @NSManaged public var iconName: String?
  @NSManaged public var id: UUID?
  @NSManaged public var lastWorkoutDate: Date?
  @NSManaged public var name: String?
  @NSManaged public var routines: NSSet?
  
  public var wrappedDesc: String {
    desc ?? "Unknown Description"
  }
  
  public var wrappedIconName: String {
    iconName ?? "barbell"
  }
  
  public var wrappedLastWorkoutDate: Date {
    lastWorkoutDate ?? Date()
  }
  
  public var wrappedName: String {
    name ?? "Unknown Name"
  }
  
  public var routinesArray: [ExerciseDetail] {
    let set = routines as? Set<ExerciseDetail> ?? []
    
    return set.sorted {
      $0.exerciseDetailIndex < $1.exerciseDetailIndex
    }
  }
    
}

// MARK: Generated accessors for routines
extension Workout {
  
  @objc(addRoutinesObject:)
  @NSManaged public func addToRoutines(_ value: ExerciseDetail)
  
  @objc(removeRoutinesObject:)
  @NSManaged public func removeFromRoutines(_ value: ExerciseDetail)
  
  @objc(addRoutines:)
  @NSManaged public func addToRoutines(_ values: NSSet)
  
  @objc(removeRoutines:)
  @NSManaged public func removeFromRoutines(_ values: NSSet)
  
}
