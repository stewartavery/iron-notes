//
//  WorkoutTemplate+CoreDataClass.swift
//  IronNotes
//
//  Created by Stewart Avery on 5/31/20.
//  Copyright © 2020 Stewart Avery. All rights reserved.
//
//

import Foundation
import CoreData


public class WorkoutTemplate: NSManagedObject {
  class func newWorkoutTemplate() -> WorkoutTemplate {
    let workoutTemplate = WorkoutTemplate(context: PersistenceController.shared.container.viewContext)
    workoutTemplate.id = UUID()
    return workoutTemplate
  }
}
