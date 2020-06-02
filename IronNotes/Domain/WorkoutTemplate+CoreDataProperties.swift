//
//  WorkoutTemplate+CoreDataProperties.swift
//  IronNotes
//
//  Created by Stewart Avery on 5/31/20.
//  Copyright © 2020 Stewart Avery. All rights reserved.
//
//

import Foundation
import CoreData


extension WorkoutTemplate {
  
  @nonobjc public class func fetchRequest() -> NSFetchRequest<WorkoutTemplate> {
    return NSFetchRequest<WorkoutTemplate>(entityName: "WorkoutTemplate")
  }
  
  @NSManaged public var desc: String
  @NSManaged public var iconName: String
  @NSManaged public var name: String
  @NSManaged public var workouts: NSSet?
  
  public var workoutSetArray: [Workout] {
     let set = workouts as? Set<Workout> ?? []
     
     return set.sorted {
       $0.startTime > $1.startTime
     }
   }
   
  
}


// MARK: Generated accessors for workouts
extension WorkoutTemplate {
  
  @objc(addWorkoutsObject:)
  @NSManaged public func addToWorkouts(_ value: Workout)
  
  @objc(removeWorkoutsObject:)
  @NSManaged public func removeFromWorkouts(_ value: Workout)
  
  @objc(addWorkouts:)
  @NSManaged public func addToWorkouts(_ values: NSSet)
  
  @objc(removeWorkouts:)
  @NSManaged public func removeFromWorkouts(_ values: NSSet)
  
}
