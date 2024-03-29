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
  
  @NSManaged public var desc: String?
  @NSManaged public var exercises: NSSet?
  @NSManaged public var exerciseType: String?
  @NSManaged public var muscleGroups: NSSet?
  @NSManaged public var name: String?
  @NSManaged public var workoutTemplates: NSSet?
  @NSManaged public var id: UUID?
  @NSManaged public var seedingGroup: SeedingGroup?
  
  public var wrappedDesc: String {
    return desc ?? ""
  }
  
  public var wrappedExerciseType: String {
    return exerciseType ?? "barbell"
  }
  
  public var wrappedName: String {
    return name ?? ""
  }
  
  public var wrappedId: UUID {
    return id ?? UUID()
  }
  
  public var exerciseArray: [Exercise] {
    return Array(exercises as? Set<Exercise> ?? [])
  }
  
}

// MARK: Helper utilities for views
extension ExerciseTemplate {
  public var displayName: String {
    return "\(wrappedName)" + (exerciseType != nil ? " (\(wrappedExerciseType))" : "")
  }
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

// MARK: Generated accessors for workoutTemplates
extension ExerciseTemplate {

    @objc(addWorkoutTemplatesObject:)
    @NSManaged public func addToWorkoutTemplates(_ value: WorkoutTemplate)

    @objc(removeWorkoutTemplatesObject:)
    @NSManaged public func removeFromWorkoutTemplates(_ value: WorkoutTemplate)

    @objc(addWorkoutTemplates:)
    @NSManaged public func addToWorkoutTemplates(_ values: NSSet)

    @objc(removeWorkoutTemplates:)
    @NSManaged public func removeFromWorkoutTemplates(_ values: NSSet)

}

// MARK:- Identifable
extension ExerciseTemplate : Identifiable {}

// MARK:- FetchRequest
extension ExerciseTemplate {
  static var getTemplates: NSFetchRequest<ExerciseTemplate> {
    let request: NSFetchRequest<ExerciseTemplate> = ExerciseTemplate.fetchRequest()
    request.sortDescriptors = []

    return request
  }
  
  static var getUserTemplates: NSFetchRequest<ExerciseTemplate> {
    let request: NSFetchRequest<ExerciseTemplate> = ExerciseTemplate.fetchRequest()
    request.sortDescriptors = []
    request.predicate = NSPredicate(format: "seedingGroup = nil")

    return request
  }
}

