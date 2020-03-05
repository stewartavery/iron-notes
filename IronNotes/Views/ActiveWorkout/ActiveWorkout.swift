//
//  ActiveWorkout.swift
//  IronNotes
//
//  Created by Stewart Avery on 2/16/20.
//  Copyright © 2020 Stewart Avery. All rights reserved.
//

import SwiftUI
import CoreData

struct ActiveWorkout: View {
  var workout: Workout
  
  var body: some View {
    List {
      ForEach(workout.routinesArray, id: \.self) { exerciseDetail in
        Group {
          ExerciseEditor(exerciseDetail: exerciseDetail)
        }
      }
    }
    .navigationBarTitle(Text(workout.wrappedName), displayMode: .large)
  }
}

struct ActiveWorkout_Previews: PreviewProvider {
  static var previews: some View {
    let workout = Workout(context: AppDelegate.viewContext)
    
    workout.name = "Test Workout"
    workout.desc = "Really good workout!"
    workout.iconName = "barbell"
    workout.lastWorkoutDate = Date()
    
    let exerciseDetail = ExerciseDetail(context: AppDelegate.viewContext)
    exerciseDetail.name = "Test"
    exerciseDetail.exerciseDetailIndex = 0
    
    let exerciseSet = ExerciseSet(context: AppDelegate.viewContext)
    exerciseSet.exerciseSetIndex = 0
    exerciseSet.reps = 3
    exerciseSet.weight = 2
    exerciseDetail.addToSets(exerciseSet)
    
    workout.addToRoutines(exerciseDetail)
    
    let exerciseDetail2 = ExerciseDetail(context: AppDelegate.viewContext)
    exerciseDetail2.name = "Test 2"
    exerciseDetail2.exerciseDetailIndex = 1
    
    let exerciseSet2 = ExerciseSet(context: AppDelegate.viewContext)
    exerciseSet2.exerciseSetIndex = 1
    exerciseSet2.reps = 5
    exerciseSet2.weight = 39
    exerciseDetail2.addToSets(exerciseSet2)
    
    workout.addToRoutines(exerciseDetail2)
    
    return ActiveWorkout(workout: workout)
  }
}


