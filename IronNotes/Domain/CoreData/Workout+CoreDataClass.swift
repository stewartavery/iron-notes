//
//  Workout+CoreDataClass.swift
//  IronNotes
//
//  Created by Stewart Avery on 5/24/20.
//  Copyright © 2020 Stewart Avery. All rights reserved.
//
//

import Foundation
import CoreData

public class Workout: NSManagedObject {
  func dayDifference(from date : Date) -> String {
    let calendar = Calendar.current
    if calendar.isDateInYesterday(date) { return "Yesterday" }
    else if calendar.isDateInToday(date) { return "Today" }
    else if calendar.isDateInTomorrow(date) { return "Tomorrow" }
    else {
      let startOfNow = calendar.startOfDay(for: Date())
      let startOfTimeStamp = calendar.startOfDay(for: date)
      let components = calendar.dateComponents([.day], from: startOfNow, to: startOfTimeStamp)
      let day = components.day!
      if day < 1 { return "\(-day) days ago" }
      else { return "In \(day) days" }
    }
  }
  
  class func newWorkout() -> Workout {
    let workout = Workout(context: PersistenceController.shared.container.viewContext)
    workout.id = UUID()
    return workout
  }
  
  class func newWorkoutWithEmptyMeta() -> Workout {
    let meta =  WorkoutTemplate.newWorkoutTemplate()
    meta.name = "New Workout"
    
    let workout = newWorkout()
    workout.meta = meta
    
    return workout
  }
  
  class func getNewWorkout(from workoutTemplate: WorkoutTemplate) -> Workout {
    let workout = newWorkout()
    workout.meta = workoutTemplate
   
    let exercises = workoutTemplate.defaultExerciseTemplatesArray
      .enumerated()
      .map { (index, exerciseTemplate) -> Exercise in
        let newExercise: Exercise = Exercise.newExercise()
        newExercise.meta = exerciseTemplate
        newExercise.position = Int16(index)
        newExercise.workout = workout
        
        return newExercise
    }
    
    workout.addToRoutines(NSSet(array: exercises))
    
    return workout
  }
  
  func deleteWorkout() -> Void {
    PersistenceController.shared.container.viewContext.delete(self)
  }
  
  public var isNotePresent: Bool {
    return wrappedNote.count > 0
  }
  
  public var readableDate: String {
    let df = DateFormatter()
    df.dateFormat = "yyyy-MM-dd hh:mm:ss"
    return df.string(from: wrappedStartTime)
  }
  
}
