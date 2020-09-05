//
//  IronNotesModelFactory.swift
//  IronNotes
//
//  Created by Stewart Avery on 8/8/20.
//  Copyright © 2020 Stewart Avery. All rights reserved.
//

import SwiftUI

class IronNotesModelFactory {
  static func getWorkoutTemplate() -> WorkoutTemplate {
    let workoutMeta = WorkoutTemplate(context: PersistenceController.shared.container.viewContext)

    workoutMeta.name = "Extra Test Workout"
    workoutMeta.desc = "Really good workout!"
    workoutMeta.iconName = "barbell"
    
    return workoutMeta
  }
  
  static func getWorkout() -> Workout {
    let workout = Workout(context: PersistenceController.shared.container.viewContext)
    let workoutMeta = WorkoutTemplate(context: PersistenceController.shared.container.viewContext)
    
    workoutMeta.name = "Extra Test Workout"
    workoutMeta.desc = "Really good workout!"
    workoutMeta.iconName = "barbell"
    workout.meta = workoutMeta
    workout.note = "This is an example of a relevant note to Bench Pressing."
    workout.startTime = Date()
    
    let exercise = Exercise(context: PersistenceController.shared.container.viewContext)
    let exerciseMeta = ExerciseTemplate(context: PersistenceController.shared.container.viewContext)
    exerciseMeta.name = "Bench Press"
    exercise.meta = exerciseMeta
    exercise.position = 0
    exercise.note = "This is a useful note for Bench Pressing."
    
    let exerciseSet = ExerciseSet(context: PersistenceController.shared.container.viewContext)
    exerciseSet.setPosition = 0
    exerciseSet.reps = 3
    exerciseSet.weight = 135
    exercise.addToSets(exerciseSet)
    
    let exerciseSet5 = ExerciseSet(context: PersistenceController.shared.container.viewContext)
    exerciseSet5.setPosition = 1
    exerciseSet5.reps = 3
    exerciseSet5.weight = 225
    exercise.addToSets(exerciseSet5)
    
    workout.addToRoutines(exercise)
    
    let exercise2 = Exercise(context: PersistenceController.shared.container.viewContext)
    let exerciseMeta2 = ExerciseTemplate(context: PersistenceController.shared.container.viewContext)
    
    exerciseMeta2.name = "Shoulder Press"
    exercise2.meta = exerciseMeta2
    exercise2.position = 1
    exercise2.note = "Hurt my shoulder last time, focus on form."
    
    let exerciseSet2 = ExerciseSet(context: PersistenceController.shared.container.viewContext)
    exerciseSet2.setPosition = 0
    exerciseSet2.reps = 5
    exerciseSet2.weight = 39
    exercise2.addToSets(exerciseSet2)
    
    workout.addToRoutines(exercise2)
    
    return workout
  }
  
  static func getExercise() -> Exercise {
    return getWorkout().routinesArray[0]
  }
  
  static func getExerciseSet() -> ExerciseSet {
    return getWorkout().routinesArray[0].exerciseSetArray[0]
  }
}


