//
//  SeedingGroup+CoreDataClass.swift
//  IronNotes
//
//  Created by Stewart Avery on 11/2/20.
//  Copyright © 2020 Stewart Avery. All rights reserved.
//
//

import Foundation
import CoreData

public class SeedingGroup: NSManagedObject {
  class func newSeedingGroup() -> SeedingGroup {
    let seedingGroup = SeedingGroup(context: PersistenceController.shared.container.viewContext)
    seedingGroup.dateCreated = Date()
    return seedingGroup
  }
  
  class func getSeedingGroup(version: String) -> SeedingGroup {
    let seedingGroup = newSeedingGroup()
    seedingGroup.version = version
    
    return seedingGroup
  }
}
