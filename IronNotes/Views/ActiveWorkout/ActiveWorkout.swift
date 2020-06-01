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
    ScrollView {
      VStack(alignment: .leading) {
        Text("Exercises")
          .font(.system(size: 22, weight: .bold))
          .padding(.bottom, 5)
        
        ForEach(workout.routinesArray, id: \.self) { exercise in
          ExerciseCard(exercise: exercise).padding(.bottom, 5)
        }
      }
    }.padding(20)
      .background(SwiftUI.Color.gray
        .opacity(0.2)
        .edgesIgnoringSafeArea(.all))
      .navigationBarTitle(Text(workout.name), displayMode: .large)
  }
  
}

struct ActiveWorkout_Previews: PreviewProvider {
  static var previews: some View {
    let workout = Workout(context: AppDelegate.viewContext)
    
    workout.name = "Extra Test Workout"
    workout.desc = "Really good workout!"
    workout.iconName = "barbell"
    workout.startTime = Date()
    
    let exercise = Exercise(context: AppDelegate.viewContext)
    exercise.name = "Bench Press"
    exercise.position = 0
    
    let exerciseSet = ExerciseSet(context: AppDelegate.viewContext)
    exerciseSet.setPosition = 0
    exerciseSet.reps = 3
    exerciseSet.weight = 135
    exercise.addToSets(exerciseSet)
    
    let exerciseSet5 = ExerciseSet(context: AppDelegate.viewContext)
    exerciseSet5.setPosition = 1
    exerciseSet5.reps = 3
    exerciseSet5.weight = 225
    exercise.addToSets(exerciseSet5)
    
    workout.addToRoutines(exercise)
    
    let exercise2 = Exercise(context: AppDelegate.viewContext)
    exercise2.name = "Shoulder Press"
    exercise2.position = 1
    
    let exerciseSet2 = ExerciseSet(context: AppDelegate.viewContext)
    exerciseSet2.setPosition = 0
    exerciseSet2.reps = 5
    exerciseSet2.weight = 39
    exercise2.addToSets(exerciseSet2)
    
    workout.addToRoutines(exercise2)
    
    return NavigationView {
      ActiveWorkout(workout: workout)
    }
  }
}



struct ActiveWorkoutSectionHeader: View {
  var exercise: Exercise
  var body: some View {
    let setTotal = exercise.exerciseSetArray.count
    
    return HStack {
      Text(exercise.name)
      Spacer()
      Text("\(setTotal) Set\(setTotal == 1 ? "" : "s")")
    }
  }
}
