//
//  ExerciseCard.swift
//  IronNotes
//
//  Created by Stewart Avery on 3/12/20.
//  Copyright © 2020 Stewart Avery. All rights reserved.
//

import SwiftUI

struct ExerciseCard: View {
  @Environment(\.managedObjectContext) var moc
  
  @ObservedObject var exercise: Exercise
  
  @State private var showDetail = false
  
  var isNotePresent: Bool {
    return exercise.note.count > 0
  }
  
  var body: some View {
    Group {
      VStack(alignment: .leading) {
        Text(exercise.meta.name)
          .font(.headline)
          .foregroundColor(Color.orange)
          .padding(.top, 10)
        if self.isNotePresent {
          Text(exercise.note)
            .font(.system(size: 15, weight: .semibold, design: .default))
            .padding(.top, 15)
        }
      }.padding(.bottom, 10)
      
      ForEach(exercise.exerciseSetArray, id: \.self) { exerciseSet in
        ExerciseCardRow(exerciseSet: exerciseSet)
      }
      .onDelete(perform: self.deleteSet)
      .animation(showDetail ? .spring() : nil)
      .transition(.move(edge: .bottom))
      .frame(height: 40)
      Button {
        self.createNewSet()
      } label: {
        AddSet()
      }
      .onAppear() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
          self.showDetail = true
        }
      }
    }
  }
  
  func deleteSet(at offsets: IndexSet) {
    var modifiedExerciseSets = self.exercise.exerciseSetArray
    modifiedExerciseSets.remove(atOffsets: offsets)
    
    // TODO: Use NSOrderedSet here?
    

    for index in offsets {
      self.moc.delete(self.exercise.exerciseSetArray[index])
    }
    
    let reorderedRoutines: [ExerciseSet] =
      modifiedExerciseSets
      .enumerated()
      .map {
        let exerciseSet = ExerciseSet(context: self.moc)
        exerciseSet.setPosition = Int16($0)
        exerciseSet.reps = Int16($1.reps)
        exerciseSet.weight = Int32($1.weight)
        exerciseSet.exercise = $1.exercise
        exerciseSet.isCompleted = $1.isCompleted
        
        return exerciseSet
      }
    
    
    do {
      try self.moc.save()
      print("Exercise removed.")
    } catch {
      print(error.localizedDescription)
    }
    
  }
  
  func createNewSet() {
    let newSet = ExerciseSet(context: moc)
    newSet.setPosition = Int16(self.exercise.exerciseSetArray.count + 1)
    newSet.reps = 3
    newSet.weight = 225
    
    self.exercise.addToSets(newSet)
    
    do {
      try self.moc.save()
      print("Set added.")
    } catch {
      print(error.localizedDescription)
    }
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
          ExerciseCard(exercise: exercise)
        }
      }
      .listStyle(InsetGroupedListStyle())
      .navigationTitle("Hey")
      .buttonStyle(BorderlessButtonStyle())
    }
    
  }
}

