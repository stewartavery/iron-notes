//
//  SeedingGroup+CoreDataProperties.swift
//  IronNotes
//
//  Created by Stewart Avery on 11/2/20.
//  Copyright © 2020 Stewart Avery. All rights reserved.
//
//

import Foundation
import CoreData


extension SeedingGroup {
  
  @nonobjc public class func fetchRequest() -> NSFetchRequest<SeedingGroup> {
    return NSFetchRequest<SeedingGroup>(entityName: "SeedingGroup")
  }
  
  @NSManaged public var version: String?
  @NSManaged public var dateCreated: Date?
  @NSManaged public var exerciseTemplates: NSSet?
  @NSManaged public var muscleGroups: NSSet?
  
  public var wrappedDateCreated: Date {
    return dateCreated ?? Date()
  }
  
  public var exerciseTemplateArray: [ExerciseTemplate] {
    let set = exerciseTemplates as? Set<ExerciseTemplate> ?? []
    
    return set.sorted {
      $0.wrappedName < $1.wrappedName
    }
  }
  
  public var muscleGroupsArray: [MuscleGroup] {
    let set = muscleGroups as? Set<MuscleGroup> ?? []
    
    return set.sorted {
      $0.wrappedName < $1.wrappedName
    }
  }
  
}

// MARK: Generated accessors for exerciseTemplates
extension SeedingGroup {
  
  @objc(addExerciseTemplatesObject:)
  @NSManaged public func addToExerciseTemplates(_ value: ExerciseTemplate)
  
  @objc(removeExerciseTemplatesObject:)
  @NSManaged public func removeFromExerciseTemplates(_ value: ExerciseTemplate)
  
  @objc(addExerciseTemplates:)
  @NSManaged public func addToExerciseTemplates(_ values: NSSet)
  
  @objc(removeExerciseTemplates:)
  @NSManaged public func removeFromExerciseTemplates(_ values: NSSet)
  
}

// MARK: Generated accessors for muscleGroups
extension SeedingGroup {
  
  @objc(addMuscleGroupsObject:)
  @NSManaged public func addToMuscleGroups(_ value: MuscleGroup)
  
  @objc(removeMuscleGroupsObject:)
  @NSManaged public func removeFromMuscleGroups(_ value: MuscleGroup)
  
  @objc(addMuscleGroups:)
  @NSManaged public func addToMuscleGroups(_ values: NSSet)
  
  @objc(removeMuscleGroups:)
  @NSManaged public func removeFromMuscleGroups(_ values: NSSet)
  
}

extension SeedingGroup : Identifiable {
  
}

extension SeedingGroup {
  static var getGroups: NSFetchRequest<SeedingGroup> {
    let request: NSFetchRequest<SeedingGroup> = SeedingGroup.fetchRequest()
    request.sortDescriptors = []
    
    return request
  }
}
