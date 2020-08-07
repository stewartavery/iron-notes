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
  @ObservedObject var workout: Workout
  @Environment(\.managedObjectContext) var moc
  @State var isEditing = false
  
  var body: some View {
    List {
      ForEach(workout.routinesArray, id: \.self) { exercise in
        if exercise.position == 0 {
          Section(header: WorkoutDescription(workout: workout, isEditing: $isEditing)) {
            ExerciseCard(exercise: exercise)
          }
          .padding(.top, 15)
        } else {
          Section {
            ExerciseCard(
              exercise: exercise
            )
          }
        }
      }
    }
    .buttonStyle(BorderlessButtonStyle())
    .sheet(
      isPresented: self.$isEditing,
      content: {
        AddExercise(isPresented: self.$isEditing, workout: self.workout)
          .environment(\.managedObjectContext, moc)
      })
    .listStyle(InsetGroupedListStyle())
    .navigationBarTitle(Text(workout.meta.name), displayMode: .large)
  }

  
  func createNewSet(exercise: Exercise) {
    let newSet = ExerciseSet(context: moc)
    newSet.setPosition = Int16(exercise.exerciseSetArray.count + 1)
    newSet.reps = 3
    newSet.weight = 225
    
    exercise.addToSets(newSet)
    
    do {
      try self.moc.save()
      print("Set added.")
    } catch {
      print(error.localizedDescription)
    }
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
    .environmentObject(StopwatchManager())
  }
}


struct AddExerciseCard: View {
  @Binding var isSheetVisible: Bool
  
  var body: some View {
    Button {
      self.isSheetVisible.toggle()
    } label: {
      Label("Edit Exercises", systemImage: "pencil.circle")
        .font(.headline)
    }
    .foregroundColor(Color.orange)
    .padding(.top, 10)
    .padding(.bottom, 10)
  }
}
