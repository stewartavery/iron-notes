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
        
        ForEach(workout.routinesArray, id: \.self) { exerciseDetail in
          ExerciseCard(exerciseDetail: exerciseDetail).padding(.bottom, 5)
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
    
    workout.id = UUID()
    workout.name = "Extra Test Workout"
    workout.desc = "Really good workout!"
    workout.iconName = "barbell"
    workout.lastWorkoutDate = Date()
    
    let exerciseDetail = ExerciseDetail(context: AppDelegate.viewContext)
    exerciseDetail.name = "Bench Press"
    exerciseDetail.exerciseDetailIndex = 0
    
    let exerciseSet = ExerciseSet(context: AppDelegate.viewContext)
    exerciseSet.exerciseSetIndex = 0
    exerciseSet.reps = 3
    exerciseSet.weight = 135
    exerciseDetail.addToSets(exerciseSet)
    
    let exerciseSet5 = ExerciseSet(context: AppDelegate.viewContext)
    exerciseSet5.exerciseSetIndex = 1
    exerciseSet5.reps = 3
    exerciseSet5.weight = 225
    exerciseDetail.addToSets(exerciseSet5)
    
    workout.addToRoutines(exerciseDetail)
    
    let exerciseDetail2 = ExerciseDetail(context: AppDelegate.viewContext)
    exerciseDetail2.name = "Shoulder Press"
    exerciseDetail2.exerciseDetailIndex = 1
    
    let exerciseSet2 = ExerciseSet(context: AppDelegate.viewContext)
    exerciseSet2.exerciseSetIndex = 0
    exerciseSet2.reps = 5
    exerciseSet2.weight = 39
    exerciseDetail2.addToSets(exerciseSet2)
    
    workout.addToRoutines(exerciseDetail2)
    
    return NavigationView {
      ActiveWorkout(workout: workout)
    }
  }
}



struct ActiveWorkoutSectionHeader: View {
  var exerciseDetail: ExerciseDetail
  var body: some View {
    let setTotal = exerciseDetail.exerciseSetArray.count
    
    return HStack {
      Text(exerciseDetail.name)
      Spacer()
      Text("\(setTotal) Set\(setTotal == 1 ? "" : "s")")
    }
  }
}
