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
          .padding(.leading)
          .padding(.bottom, 5)
        
        ForEach(workout.routinesArray, id: \.self) { exercise in
          ExerciseCard(
            exercise: exercise,
            workout: self.workout
          )
          .padding(.leading)
          .padding(.trailing)
          .padding(.bottom, 20)
        }
      }
    }
    .navigationBarTitle(Text(workout.meta.name), displayMode: .large)
    .padding(.leading, 5)
    .padding(.trailing, 5)
  }
  
}

struct ActiveWorkout_Previews: PreviewProvider {
  static var previews: some View {
    let workout = Workout(context: AppDelegate.viewContext)
    let workoutMeta = WorkoutTemplate(context: AppDelegate.viewContext)
    
    workoutMeta.name = "Extra Test Workout"
    workoutMeta.desc = "Really good workout!"
    workoutMeta.iconName = "barbell"
    workout.meta = workoutMeta
    workout.note = "This is an example of a relevant note to Bench Pressing."
    workout.startTime = Date()
    
    let exercise = Exercise(context: AppDelegate.viewContext)
    let exerciseMeta = ExerciseTemplate(context: AppDelegate.viewContext)
    exerciseMeta.name = "Bench Press"
    exercise.meta = exerciseMeta
    exercise.position = 0
    exercise.note = "This is a useful note for Bench Pressing."
    
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
    let exerciseMeta2 = ExerciseTemplate(context: AppDelegate.viewContext)
    
    exerciseMeta2.name = "Shoulder Press"
    exercise2.meta = exerciseMeta2
    exercise2.position = 1
    exercise2.note = "Hurt my shoulder last time, focus on form."
    
    let exerciseSet2 = ExerciseSet(context: AppDelegate.viewContext)
    exerciseSet2.setPosition = 0
    exerciseSet2.reps = 5
    exerciseSet2.weight = 39
    exercise2.addToSets(exerciseSet2)
    
    workout.addToRoutines(exercise2)
    
    return NavigationView {
      ActiveWorkout(workout: workout)
    }.navigationViewStyle(StackNavigationViewStyle())
    
  }
}

struct ActiveWorkoutSectionHeader: View {
  var exercise: Exercise
  var body: some View {
    let setTotal = exercise.exerciseSetArray.count
    
    return HStack {
      Text(exercise.meta.name)
      Spacer()
      Text("\(setTotal) Set\(setTotal == 1 ? "" : "s")")
    }
  }
}
