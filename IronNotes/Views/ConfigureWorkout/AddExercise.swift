//
//  AddExercise.swift
//  IronNotes
//
//  Created by Stewart Avery on 6/2/20.
//  Copyright © 2020 Stewart Avery. All rights reserved.
//

import SwiftUI

struct AddExercise: View {
  @Environment(\.managedObjectContext) var moc
  @Binding var isPresented: Bool
  @FetchRequest(entity: ExerciseTemplate.entity(),
                sortDescriptors: [NSSortDescriptor(keyPath: \ExerciseTemplate.name, ascending: true)]
  ) var exerciseTemplates: FetchedResults<ExerciseTemplate>
  
  var workout: Workout
  
  var addedExercises: [ExerciseTemplate] {
    return self.workout.routinesArray.map { $0.meta }
  }
  
  var unaddedExercises: [ExerciseTemplate] {
    return exerciseTemplates.filter {
      !self.addedExercises.contains($0)
    }
  }
  
  var body: some View {
    NavigationView {
      List {
        if self.addedExercises.count > 0 {
          Section(header: Text("Added Exercises")) {
            ForEach(self.addedExercises, id: \.self) { addedExerciseTemplate in
              RemoveExerciseRow(exerciseTemplate: addedExerciseTemplate)
            }
            .onDelete(perform: self.removeRow)
            .onMove(perform: self.moveRow)
            
          }
        }
        Section(header: Text("More Exercises")) {
          ForEach(unaddedExercises, id: \.self) { unaddedExerciseTemplate in
            AddExerciseRow(exerciseTemplate: unaddedExerciseTemplate, addRow: self.addRow)
          }
          .disabled(false)
        }
      }
      .environment(\.editMode, Binding.constant(EditMode.active))
      .listStyle(InsetGroupedListStyle())
      .navigationBarTitle(Text("Modify Exercises"), displayMode: .inline)
      .navigationBarItems(leading:
                            Button("Cancel") {
                              self.isPresented.toggle()
                            },trailing: Button("Done") {
                              self.isPresented.toggle()
                            })
    }
  }
  
  func moveRow(from source: IndexSet, to destination: Int) {
    var modifiedRoutines = self.workout.routinesArray
    modifiedRoutines.move(fromOffsets: source, toOffset: destination)
    
    self.workout.routines = NSSet(
      array: modifiedRoutines
        .enumerated()
        .map {
          Exercise.getExercise(
            meta: $1.meta,
            note: $1.note,
            position: Int16($0),
            sets: $1.exerciseSetArray,
            workout: $1.workout
          )
        }
    )
    
    do {
      try self.moc.save()
      print("Exercise moved.")
    } catch {
      print(error.localizedDescription)
    }
  }
  
  
  func removeRow(at offsets: IndexSet) {
    var modifiedRoutines = self.workout.routinesArray
    modifiedRoutines.remove(atOffsets: offsets)
    
    // TODO: Use NSOrderedSet here?
    
    
    for oldRoutine in self.workout.routinesArray {
      self.moc.delete(oldRoutine)
    }
    
    let reorderedRoutines = modifiedRoutines
      .enumerated()
      .map {
        Exercise.getExercise(
          meta: $1.meta,
          note: $1.note,
          position: Int16($0),
          sets: $1.exerciseSetArray,
          workout: $1.workout
        )
      }
    
    for newRoutine in reorderedRoutines {
      self.workout.addToRoutines(newRoutine)
    }
    
    do {
      try self.moc.save()
      print("Exercise removed.")
    } catch {
      print(error.localizedDescription)
    }
  }
  
  
  func addRow(exercise: ExerciseTemplate) {
    let newExercise: Exercise = Exercise(context: self.moc)
    
    newExercise.meta = exercise
    newExercise.position = Int16(self.workout.routinesArray.count + 1)
    newExercise.workout = self.workout
    
    self.workout.addToRoutines(newExercise)
    
    do {
      try self.moc.save()
      print("Exercise added: \(newExercise.meta.name)")
    } catch {
      print(error.localizedDescription)
    }
  }
}

struct RemoveExerciseRow: View {
  var exerciseTemplate: ExerciseTemplate
  @Environment(\.colorScheme) var colorScheme: ColorScheme
  
  var body: some View {
    Text(self.exerciseTemplate.name)
      .font(.body)
      .foregroundColor(colorScheme == .light ? Color.black : Color.white)
  }
  
  
}


struct AddExerciseRow: View {
  var exerciseTemplate: ExerciseTemplate
  @Environment(\.colorScheme) var colorScheme: ColorScheme
  var addRow: (ExerciseTemplate) -> Void
  
  var body: some View {
    HStack {
      Button {
      } label: {
        Image(systemName: "plus.circle.fill")
          .foregroundColor(Color.green)
          .padding(.trailing, 10)
      }.onTapGesture {
        self.addRow(self.exerciseTemplate)
      }
      
      Text(self.exerciseTemplate.name)
        .font(.body)
        .foregroundColor(colorScheme == .light ? Color.black : Color.white)
    }
  }
}


func testFunc(templates: [ExerciseTemplate]) {
  print("Test")
}

struct AddExercise_Previews: PreviewProvider {
  @State static var isModalPresented = true
  
  
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
    
    return AddExercise(isPresented: $isModalPresented, workout: workout)
      .environment(\.managedObjectContext, AppDelegate.viewContext)
    
  }
}
