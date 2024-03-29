//
//  MuscleGroup+CoreDataProperties.swift
//  IronNotes
//
//  Created by Stewart Avery on 5/7/20.
//  Copyright © 2020 Stewart Avery. All rights reserved.
//
//

import Foundation
import CoreData


extension MuscleGroup {
  
  @nonobjc public class func fetchRequest() -> NSFetchRequest<MuscleGroup> {
    return NSFetchRequest<MuscleGroup>(entityName: "MuscleGroup")
  }
  
  @NSManaged public var name: String?
  @NSManaged public var exerciseTemplates: NSSet?
  @NSManaged public var seedingGroup: SeedingGroup?
  
  public var wrappedName: String {
    return name ?? ""
  }
  
  public var exerciseTemplateArray: [ExerciseTemplate] {
    let set = exerciseTemplates as? Set<ExerciseTemplate> ?? []
    
    return set.sorted {
      $0.wrappedName < $1.wrappedName
    }
  }
}


extension MuscleGroup {
  
  @objc(addRoutinesObject:)
  @NSManaged public func addToExercises(_ value: Exercise)
  
  @objc(removeRoutinesObject:)
  @NSManaged public func removeFromExercises(_ value: Exercise)
  
  @objc(addRoutines:)
  @NSManaged public func addToExercises(_ values: NSSet)
  
  @objc(removeRoutines:)
  @NSManaged public func removeFromExercises(_ values: NSSet)
  
}
