//
//  Workout+CoreDataProperties.swift
//  IronNotes
//
//  Created by Stewart Avery on 5/24/20.
//  Copyright © 2020 Stewart Avery. All rights reserved.
//
//

import Foundation
import CoreData


extension Workout {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Workout> {
        return NSFetchRequest<Workout>(entityName: "Workout")
    }

    @NSManaged public var startTime: Date?
    @NSManaged public var duration: Int16
    @NSManaged public var note: String?
    @NSManaged public var routines: ExerciseTemplate?

}
