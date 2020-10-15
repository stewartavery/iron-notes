//
//  Workout+CoreDataProperties.swift
//  IronNotes
//
//  Created by Stewart Avery on 5/31/20.
//  Copyright © 2020 Stewart Avery. All rights reserved.
//
//

import Foundation
import CoreData


extension Workout {
  
  @nonobjc public class func fetchRequest() -> NSFetchRequest<Workout> {
    return NSFetchRequest<Workout>(entityName: "Workout")
  }
  
  @NSManaged public var duration: Int16
  @NSManaged public var note: String?
  @NSManaged public var startTime: Date?
  @NSManaged public var id: UUID?
  @NSManaged public var routines: NSSet?
  @NSManaged public var meta: WorkoutTemplate?
  
  public var wrappedNote: String {
    return note ?? ""
  }
  
  public var isNotePresent: Bool {
    return wrappedNote.count > 0
  }
  
  public var wrappedStartTime: Date {
    return startTime ?? Date()
  }

  public var routinesArray: [Exercise] {
    let set = routines as? Set<Exercise> ?? []
    
    return set.sorted {
      $0.position < $1.position
    }
  }
  
  public var readableDate: String {
    let df = DateFormatter()
    df.dateFormat = "yyyy-MM-dd hh:mm:ss"
    return df.string(from: wrappedStartTime)
  }
  
}

extension Workout : Identifiable {

}

extension Workout {
  
  @objc(addRoutinesObject:)
  @NSManaged public func addToRoutines(_ value: Exercise)
  
  @objc(removeRoutinesObject:)
  @NSManaged public func removeFromRoutines(_ value: Exercise)
  
  @objc(addRoutines:)
  @NSManaged public func addToRoutines(_ values: NSSet)
  
  @objc(removeRoutines:)
  @NSManaged public func removeFromRoutines(_ values: NSSet)
  
}

extension Workout {
  static var getWorkouts: NSFetchRequest<Workout> {
    let request: NSFetchRequest<Workout> = Workout.fetchRequest()
    request.sortDescriptors = [
      NSSortDescriptor(keyPath: \Workout.startTime, ascending: false)
    ]
    
    // TODO: figure out filtering out null dates
    
    return request
  }
}

