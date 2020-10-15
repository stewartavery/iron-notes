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
  
  @NSManaged public var desc: String?
  @NSManaged public var iconName: String?
  @NSManaged public var name: String?
  @NSManaged public var workouts: NSSet?
  @NSManaged public var defaultExerciseTemplates: NSSet?
  @NSManaged public var id: UUID?
  
  public var workoutSetArray: [Workout] {
     let set = workouts as? Set<Workout> ?? []
     
     return set.sorted {
       $0.wrappedStartTime > $1.wrappedStartTime
     }
   }
  
  public var defaultExerciseTemplatesArray: [ExerciseTemplate] {
      let set = defaultExerciseTemplates as? Set<ExerciseTemplate> ?? []
      
      return set.sorted {
        $0.name > $1.name
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

extension WorkoutTemplate: Identifiable {
  
}

// MARK: Generated accessors for defaultExerciseTemplates
extension WorkoutTemplate {

    @objc(addDefaultExerciseTemplatesObject:)
    @NSManaged public func addToDefaultExerciseTemplates(_ value: ExerciseTemplate)

    @objc(removeDefaultExerciseTemplatesObject:)
    @NSManaged public func removeFromDefaultExerciseTemplates(_ value: ExerciseTemplate)

    @objc(addDefaultExerciseTemplates:)
    @NSManaged public func addToDefaultExerciseTemplates(_ values: NSSet)

    @objc(removeDefaultExerciseTemplates:)
    @NSManaged public func removeFromDefaultExerciseTemplates(_ values: NSSet)

}

extension WorkoutTemplate {
  static var getTemplates: NSFetchRequest<WorkoutTemplate> {
    let request: NSFetchRequest<WorkoutTemplate> = WorkoutTemplate.fetchRequest()
    request.sortDescriptors = []

    return request
  }
}
