//
//  ExerciseSet+CoreDataProperties.swift
//  IronNotes
//
//  Created by Stewart Avery on 3/3/20.
//  Copyright © 2020 Stewart Avery. All rights reserved.
//
//

import Foundation
import CoreData


extension ExerciseSet {
  
  @nonobjc public class func fetchRequest() -> NSFetchRequest<ExerciseSet> {
    return NSFetchRequest<ExerciseSet>(entityName: "ExerciseSet")
  }
  
  @NSManaged public var position: Int16
  @NSManaged public var reps: Int16
  @NSManaged public var weight: Int32
  @NSManaged public var exercise: Exercise?
  
}
