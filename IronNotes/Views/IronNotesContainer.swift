//
//  IronNotesContainer.swift
//  IronNotes
//
//  Created by Stewart Avery on 7/21/19.
//  Copyright © 2019 Stewart Avery. All rights reserved.
//

import SwiftUI

struct IronNotesContainer: View {
  @StateObject var stopwatchManager = StopwatchManager()
  
  var body: some View {
    TabView {
      StartWorkoutList()
        .font(.title)
        .tabItem({
          VStack {
            Image(systemName: "flame.fill")
            Text("Workouts")
          }
        })
        .tag(0)
      ExerciseList()
        .font(.title)
        .tabItem({
          VStack {
            Image(systemName: "book.fill")
            Text("Exercises")
          }
        })
        .tag(1)
      Text("History")
        .font(.title)
        .tabItem({
          VStack {
            Image(systemName: "clock.fill")
            Text("History")
          }
        })
        .tag(2)
      Text("Settings")
        .font(.title)
        .tabItem({
          VStack {
            Image(systemName: "gear")
            Text("Settings")
          }
        })
        .tag(3)
    }.environmentObject(stopwatchManager)
  }
}

#if DEBUG
struct IronNotesContainer_Previews: PreviewProvider {
  static var previews: some View {
    
    let workout = Workout(context: AppDelegate.viewContext)
    let workoutMeta = WorkoutTemplate(context: AppDelegate.viewContext)
    
    workoutMeta.name = "Test Workout"
    workoutMeta.desc = "Really good workout!"
    workoutMeta.iconName = "barbell"
    workout.meta = workoutMeta
    workout.startTime = Date()
    
    let exercise = Exercise(context: AppDelegate.viewContext)
    let exerciseMeta = ExerciseTemplate(context: AppDelegate.viewContext)
    exerciseMeta.name = "Test"
    exercise.meta = exerciseMeta
    exercise.position = 0
    
    let exerciseSet = ExerciseSet(context: AppDelegate.viewContext)
    exerciseSet.setPosition = 0
    exerciseSet.reps = 3
    exerciseSet.weight = 2
    exercise.addToSets(exerciseSet)
    
    workout.addToRoutines(exercise)
    
    let exercise2 = Exercise(context: AppDelegate.viewContext)
    let exerciseMeta2 = ExerciseTemplate(context: AppDelegate.viewContext)

    exerciseMeta2.name = "Test 2"
    exercise2.meta = exerciseMeta2
    exercise2.position = 1
    
    let exerciseSet2 = ExerciseSet(context: AppDelegate.viewContext)
    exerciseSet2.setPosition = 1
    exerciseSet2.reps = 5
    exerciseSet2.weight = 39
    exercise2.addToSets(exerciseSet2)
    
    workout.addToRoutines(exercise2)
    
    return IronNotesContainer().environment(\.managedObjectContext, AppDelegate.viewContext)
    
  }
}
#endif

