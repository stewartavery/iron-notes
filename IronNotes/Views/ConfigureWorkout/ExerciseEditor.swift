//
//  ExerciseEditor.swift
//  IronNotes
//
//  Created by Stewart Avery on 6/2/20.
//  Copyright © 2020 Stewart Avery. All rights reserved.
//

import SwiftUI

struct ExerciseEditor: View {
  @Environment(\.managedObjectContext) var moc
  @ObservedObject var workout: Workout
  @Binding var isPresented: Bool
  @FetchRequest(
    entity: ExerciseTemplate.entity(),
    sortDescriptors: [NSSortDescriptor(keyPath: \ExerciseTemplate.name, ascending: true
    )]) var exerciseTemplates: FetchedResults<ExerciseTemplate>
  
  var body: some View {
    let addedTemplates = self.workout.routinesArray.map { $0.meta }
    let unaddedExercises = exerciseTemplates.filter {
      !addedTemplates.contains($0)
    }
    
    return NavigationView {
      List {
        if addedTemplates.count > 0 {
          Section(header: Text("Added Exercises")) {
            ForEach(addedTemplates, id: \.self) {
              RemoveExerciseRow(exerciseTemplate: $0)
            }
            .onDelete(perform: self.removeRow)
            .onMove(perform: self.moveRow)
          }
        }
        Section(header: Text("More Exercises")) {
          ForEach(unaddedExercises, id: \.self) {
            AddExerciseRow(exerciseTemplate: $0, addRow: self.addRow)
          }
        }
      }
      .environment(\.editMode, Binding.constant(EditMode.active))
      .listStyle(InsetGroupedListStyle())
      .navigationBarTitle(Text("Modify Exercises"), displayMode: .inline)
      .navigationBarItems(
        trailing: Button("Done") {
          self.isPresented.toggle()
        }
      )
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
    
    print(modifiedRoutines)
    
    do {
      try self.moc.save()
    } catch {
      print(error.localizedDescription)
    }
  }
  
  
  func removeRow(at offsets: IndexSet) {
    var modifiedRoutines = self.workout.routinesArray
    modifiedRoutines.remove(atOffsets: offsets)
    
    for index in offsets {
      self.moc.delete(self.workout.routinesArray[index])
    }
    
    for reverseIndex in stride(
      from: modifiedRoutines.count - 1,
      through: 0,
      by: -1 ) {
      modifiedRoutines[reverseIndex].position = Int16(reverseIndex)
    }
  }
  
  func addRow(exercise: ExerciseTemplate) {
    let newExercise: Exercise = Exercise(context: self.moc)
    
    newExercise.meta = exercise
    newExercise.position = Int16(self.workout.routinesArray.count)
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

#if DEBUG
struct AddExercise_Previews: PreviewProvider {
  @State static var isModalPresented = true
  
  static var previews: some View {
    ExerciseEditor(
      workout: IronNotesModelFactory.getWorkout(),
      isPresented: $isModalPresented
    ).environment(\.managedObjectContext, AppDelegate.viewContext)
  }
}
#endif