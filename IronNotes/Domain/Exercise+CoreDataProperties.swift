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
  
  @NSManaged public var desc: String?
  @NSManaged public var exerciseTypeValue: Int16
  @NSManaged public var muscleGroupValue: Int16
  @NSManaged public var name: String?
  
  public var wrappedName: String {
    name ?? "Unknown Name"
  }
  
  public var wrappedDesc: String {
    desc ?? "Unknown Description"
  }
  
}
