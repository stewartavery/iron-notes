//
//  ExerciseCard.swift
//  IronNotes
//
//  Created by Stewart Avery on 3/12/20.
//  Copyright © 2020 Stewart Avery. All rights reserved.
//

import SwiftUI

struct ExerciseCard: View {
  
  var exercise: Exercise
  var workout: Workout
  
  @State private var showDetail = false
  
  var body: some View {
    VStack(alignment: .leading) {
      Text(exercise.meta.name)
        .font(.headline)
        .foregroundColor(Color.orange)
        .padding(.bottom, 15)
        .padding(.top, 10)
      
      Text(exercise.note)
        .font(.system(size: 15, weight: .semibold, design: .default))
      
      Divider()
      ForEach(exercise.exerciseSetArray, id: \.self) { exerciseSet in
        ExerciseCardRow(exerciseSet: exerciseSet)
      }
      .animation(showDetail ? .spring() : .none)
      .transition(.move(edge: .bottom))
      .frame(height: 50)
      Button {
        withAnimation {
          self.showDetail.toggle()
        }
        self.createNewSet()
      } label: {
        AddSet()
      }
    }
  }
  
  func createNewSet() {
    let newSet = ExerciseSet(context: AppDelegate.viewContext)
    newSet.setPosition = Int16(self.exercise.exerciseSetArray.count + 1)
    newSet.reps = 3
    newSet.weight = 225
    
    self.exercise.addToSets(newSet)
    self.workout.managedObjectContext?.refresh(self.workout, mergeChanges: true)
    
    try? AppDelegate.viewContext.save()
  }
}

struct ExerciseCard_Previews: PreviewProvider {
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
    exerciseMeta.name = "Test"
    exercise.meta = exerciseMeta
    exercise.position = 0
    exercise.note = "This is a test note."
    
    let exerciseSet = ExerciseSet(context: AppDelegate.viewContext)
    exerciseSet.setPosition = 0
    exerciseSet.reps = 3
    exerciseSet.weight = 135
    exercise.addToSets(exerciseSet)
    
    let exerciseSet2 = ExerciseSet(context: AppDelegate.viewContext)
    exerciseSet.setPosition = 1
    exerciseSet2.reps = 3
    exerciseSet2.weight = 225
    exercise.addToSets(exerciseSet2)
    
    workout.addToRoutines(exercise)
    
    return NavigationView {
      List {
        Section {
          ExerciseCard(exercise: exercise, workout: workout)
        }
      }
      .listStyle(InsetGroupedListStyle())
      .navigationTitle("Hey")
      .buttonStyle(BorderlessButtonStyle())
    }
    
  }
}


