//
//  MuscleGroup+CoreDataClass.swift
//  IronNotes
//
//  Created by Stewart Avery on 5/7/20.
//  Copyright © 2020 Stewart Avery. All rights reserved.
//
//

import Foundation
import CoreData


public class MuscleGroup: NSManagedObject {
  class func newMuscleGroup() -> MuscleGroup {
    let meta = MuscleGroup(context: PersistenceController.shared.container.viewContext)
    return meta
  }
  
  class func createMuscleGroupFor(name: String, seedingGroup: SeedingGroup) -> Void {
    let muscleGroup = newMuscleGroup()
    muscleGroup.name = name
    muscleGroup.seedingGroup = seedingGroup

    try! PersistenceController.shared.container.viewContext.save()
  }
  
  class func getMuscleGroupFor(name: String, seedingGroup: SeedingGroup) -> MuscleGroup {
    let muscleGroup = newMuscleGroup()
    muscleGroup.name = name
    muscleGroup.seedingGroup = seedingGroup
    
    return muscleGroup
  }
}
