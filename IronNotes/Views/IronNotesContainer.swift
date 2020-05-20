//
//  IronNotesContainer.swift
//  IronNotes
//
//  Created by Stewart Avery on 7/21/19.
//  Copyright © 2019 Stewart Avery. All rights reserved.
//

import SwiftUI

struct IronNotesContainer: View {
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
      
    }
  }
}

#if DEBUG
struct IronNotesContainer_Previews: PreviewProvider {
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
    
    return IronNotesContainer().environment(\.managedObjectContext, AppDelegate.viewContext)
    
  }
}
#endif

