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
  @Binding var refreshing: Bool
  @State private var showDetail = false

  
  var body: some View {
    VStack {
      VStack(alignment: .leading) {
        Text(exercise.meta.name)
          .font(.headline)
          .foregroundColor(Color.orange)
          .padding(.bottom, 15)
        
        Text(exercise.note)
          .font(.system(size: 15, weight: .semibold, design: .default))
        
        Divider()
        ForEach(exercise.exerciseSetArray, id: \.self) { exerciseSet in
          VStack {
            Spacer()
            HStack(alignment: .center, spacing: 8) {
              CompletionCircle()
              HStack(alignment: .firstTextBaseline, spacing: 2) {
                
                Text(String(exerciseSet.weight))
                  .font(.headline)
                Text("lbs")
                  .font(.caption)
                  .foregroundColor(Color.gray)
              }
              
              Image(systemName: "multiply")
                .foregroundColor(Color.gray)
              
              HStack(alignment: .firstTextBaseline, spacing: 2) {
                Text(String(exerciseSet.reps))
                  .font(.headline)
                Text("reps")
                  .font(.caption)
                  .foregroundColor(Color.gray)
              }
              Spacer()
              
            }
            Spacer()
            Divider()
          }
        }
        .animation(showDetail ? .spring() : .none)
        .transition(.move(edge: .bottom))
        .frame(height: 50)
        Button(action: {
          withAnimation {
            self.showDetail.toggle()
          }
          self.createNewSet()
        }) {
          HStack(alignment: .firstTextBaseline, spacing: 8) {
            Image(systemName: "plus.circle.fill")
              .foregroundColor(Color.orange)
            Text("Add Set")
              .font(.headline)
              .foregroundColor(Color.orange)
            Spacer()
          }.frame(height: 33)
        }
      }
      .padding()
    }
    .background(Color.white)
    .cornerRadius(10)
    .overlay(
        RoundedRectangle(cornerRadius: 10)
          .stroke(Color.gray, lineWidth: 0.5)
    )
  }
  
  func createNewSet() {
    let newSet = ExerciseSet(context: AppDelegate.viewContext)
    newSet.setPosition = Int16(self.exercise.exerciseSetArray.count + 1)
    newSet.reps = 3
    newSet.weight = 225
    
    self.exercise.addToSets(newSet)
    self.workout.managedObjectContext?.refresh(self.workout, mergeChanges: true)
    
    try? AppDelegate.viewContext.save()
    
    self.refreshing.toggle()
  }
}

struct ExerciseCard_Previews: PreviewProvider {
  @State static var refreshing = false
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
    
    return ExerciseCard(exercise: exercise, workout: workout, refreshing: $refreshing)
    
  }
}
