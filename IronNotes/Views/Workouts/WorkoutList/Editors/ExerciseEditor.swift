//
//  ExerciseEditor.swift
//  IronNotes
//
//  Created by Stewart Avery on 6/2/20.
//  Copyright © 2020 Stewart Avery. All rights reserved.
//

import SwiftUI

struct ExerciseEditor: View {
  @Environment(\.presentationMode) var presentationMode
  @Environment(\.managedObjectContext) var moc
  @ObservedObject var workout: Workout
  
  @FetchRequest(
    entity: ExerciseTemplate.entity(),
    sortDescriptors: [NSSortDescriptor(keyPath: \ExerciseTemplate.name, ascending: true
                                      )]) var exerciseTemplates: FetchedResults<ExerciseTemplate>
  
  var addedTemplates: [ExerciseTemplate] {
    return workout.routinesArray.compactMap { $0.meta }
  }
  
  var unaddedExercises: [ExerciseTemplate] {
    return exerciseTemplates.filter {
      !addedTemplates.contains($0)
    }
  }
  
  var hasAddedTemplates: Bool {
    return addedTemplates.count > 0
  }
  
  var body: some View {
    NavigationView {
      List {
        Section(header: Text("Added Exercises")) {
          if hasAddedTemplates {
            ForEach(addedTemplates) {
              RemoveExerciseRow(exerciseTemplate: $0)
            }
            .onDelete(perform: removeRow)
            .onMove(perform: moveRow)
          } else {
            Text("Add some exercises below to get started!")
          }
        }
        
        
        Section(header: Text("More Exercises")) {
          ForEach(unaddedExercises) {
            AddExerciseRow(exerciseTemplate: $0, addRow: addRow)
          }
        }
      }
      .listStyle(InsetGroupedListStyle())
      .navigationBarTitle(Text("Modify Exercises"), displayMode: .inline)
      .toolbar {
        ToolbarItem(placement: .primaryAction) {
          Button("Done") {
            presentationMode.wrappedValue.dismiss()
          }
        }
      }
    }
  }
  
  func moveRow(from source: IndexSet, to destination: Int) {
    var modifiedRoutines = workout.routinesArray
    modifiedRoutines.move(fromOffsets: source, toOffset: destination)
    
    for reverseIndex in stride(
      from: modifiedRoutines.count - 1,
      through: 0,
      by: -1) {
      modifiedRoutines[reverseIndex].position = Int16(reverseIndex)
    }
    
    do {
      try moc.save()
    } catch {
      print(error.localizedDescription)
    }
  }
  
  
  func removeRow(at offsets: IndexSet) {
    var modifiedRoutines = workout.routinesArray
    modifiedRoutines.remove(atOffsets: offsets)
    
    for index in offsets {
      moc.delete(workout.routinesArray[index])
    }
    
    for reverseIndex in stride(
      from: modifiedRoutines.count - 1,
      through: 0,
      by: -1 ) {
      modifiedRoutines[reverseIndex].position = Int16(reverseIndex)
    }
  }
  
  func addRow(exercise: ExerciseTemplate) {
    let newExercise: Exercise = Exercise.newExercise()
    
    newExercise.meta = exercise
    newExercise.position = Int16(workout.routinesArray.count)
    newExercise.workout = workout
    
    workout.addToRoutines(newExercise)
    
    do {
      try moc.save()
      print("Exercise added: \(exercise.wrappedName)")
    } catch {
      print(error.localizedDescription)
    }
  }
}

struct RemoveExerciseRow: View {
  var exerciseTemplate: ExerciseTemplate
  
  var body: some View {
    Label {
      Text(exerciseTemplate.wrappedName)
      
    } icon: {
      Image(systemName: "minus.circle.fill")
        .foregroundColor(Color.red)
        .font(.title3)
    }
  }
}


struct AddExerciseRow: View {
  var exerciseTemplate: ExerciseTemplate
  var addRow: (ExerciseTemplate) -> Void
  
  var body: some View {
    Label {
      Text(exerciseTemplate.wrappedName)
    } icon: {
      Image(systemName: "plus.circle.fill")
        .foregroundColor(Color.green)
        .font(.title3)
    }.onTapGesture {
      withAnimation(.easeOut(duration: 3).delay(2)) {
        addRow(exerciseTemplate)
      }
    }
  }
}

#if DEBUG
struct AddExercise_Previews: PreviewProvider {
  static var previews: some View {
    ExerciseEditor(workout: IronNotesModelFactory.getWorkout())
      .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
  }
}
#endif
