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
          Section(header:
            ActiveWorkoutSectionHeader(exerciseDetail: exerciseDetail)
          ) {
            ForEach(exerciseDetail.exerciseSetArray, id: \.self) { exerciseSet in
              HStack {
                VStack(alignment: .leading) {
                  Text("Weight")
                    .font(.headline)
                  Text(String(exerciseSet.weight) + " lbs")
                    .font(.subheadline)
                }
                Spacer()
                VStack(alignment: .trailing) {
                  Text("Reps")
                    .font(.headline)
                  Text(String(exerciseSet.reps))
                    .font(.subheadline)
                }
              }
            }.frame(height: 60)
          }
        }
      }
      .onDelete(perform: delete)
      .onMove(perform: move)
    }
    .navigationBarTitle(Text(workout.wrappedName), displayMode: .large)
    .navigationBarItems(trailing: EditButton())
  }
  
  func delete(from source: IndexSet) {
    //
  }
  
  func move(from source: IndexSet, to destination: Int) {
//      users.move(fromOffsets: source, toOffset: destination)
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
    
    let exerciseSet5 = ExerciseSet(context: AppDelegate.viewContext)
    exerciseSet.exerciseSetIndex = 0
    exerciseSet.reps = 3
    exerciseSet.weight = 2
    exerciseDetail.addToSets(exerciseSet5)
    
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
      Text(exerciseDetail.wrappedName)
      Spacer()
      Text("\(setTotal) Set\(setTotal == 1 ? "" : "s")")
    }
  }
}
