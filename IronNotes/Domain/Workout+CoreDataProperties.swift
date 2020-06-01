//
//  Workout+CoreDataProperties.swift
//  IronNotes
//
//  Created by Stewart Avery on 5/31/20.
//  Copyright © 2020 Stewart Avery. All rights reserved.
//
//

import Foundation
import CoreData


extension Workout {
  
  @nonobjc public class func fetchRequest() -> NSFetchRequest<Workout> {
    return NSFetchRequest<Workout>(entityName: "Workout")
  }
  
  @NSManaged public var duration: Int16
  @NSManaged public var note: String?
  @NSManaged public var startTime: Date
  @NSManaged public var routines: NSSet?

  public var routinesArray: [Exercise] {
    let set = routines as? Set<Exercise> ?? []
    
    return set.sorted {
      $0.position < $1.position
    }
  }
  
}
extension Workout {
  
  @objc(addRoutinesObject:)
  @NSManaged public func addToRoutines(_ value: Exercise)
  
  @objc(removeRoutinesObject:)
  @NSManaged public func removeFromRoutines(_ value: Exercise)
  
  @objc(addRoutines:)
  @NSManaged public func addToRoutines(_ values: NSSet)
  
  @objc(removeRoutines:)
  @NSManaged public func removeFromRoutines(_ values: NSSet)
  
}
