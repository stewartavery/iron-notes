//
//  WorkoutTemplate+CoreDataProperties.swift
//  IronNotes
//
//  Created by Stewart Avery on 5/24/20.
//  Copyright © 2020 Stewart Avery. All rights reserved.
//
//

import Foundation
import CoreData


extension WorkoutTemplate {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WorkoutTemplate> {
        return NSFetchRequest<WorkoutTemplate>(entityName: "WorkoutTemplate")
    }

    @NSManaged public var desc: String
    @NSManaged public var iconName: String
    @NSManaged public var name: String
    @NSManaged public var muscleGroups: MuscleGroup?

}
