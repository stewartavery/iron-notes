//
//  Exercise+CoreDataProperties.swift
//  IronNotes
//
//  Created by Stewart Avery on 3/3/20.
//  Copyright © 2020 Stewart Avery. All rights reserved.
//
//

import Foundation
import CoreData


extension Exercise {
  
  @nonobjc public class func fetchRequest() -> NSFetchRequest<Exercise> {
    return NSFetchRequest<Exercise>(entityName: "Exercise")
  }
  
  @NSManaged public var desc: String
  @NSManaged public var exerciseType: String
  @NSManaged public var muscleGroup: MuscleGroup
  @NSManaged public var name: String
  
}
