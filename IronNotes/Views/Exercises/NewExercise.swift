//
//  NewExercise.swift
//  IronNotes
//
//  Created by Stewart Avery on 3/25/20.
//  Copyright © 2020 Stewart Avery. All rights reserved.
//

import SwiftUI


struct NewExercise: View {
  @Binding var isPresented: Bool
  
  @State private var name: String = ""
  @State private var description: String = ""
  @State private var exerciseType: ExerciseType = ExerciseType.barbell
  
  @ObservedObject var selectedMuscleGroups = SelectedMuscleGroups()
  
  var body: some View {
    NavigationView {
      VStack {
        Form {
          Section {
            TextField("Exercise name", text: $name)
            TextField("Description", text: $description)
          }
          Section {
            Picker(selection: $exerciseType, label: Text("Type of Exercise")) {
              ForEach(ExerciseType.allCases, id: \.self) { e in
                Text(e.rawValue)
              }
            }
          }
          Section {
            NavigationLink(destination: MuscleGroupPicker(selectedMuscleGroups: selectedMuscleGroups).environment(\.managedObjectContext, AppDelegate.viewContext)) {
              Text("Muscle Groups")
            }
          }
        }
      }
      .navigationBarTitle(Text("New Exercise"), displayMode: .inline)
      .navigationBarItems(leading:
        Button("Cancel") { // todo: fix touch target
          self.isPresented.toggle()
        },trailing: Button("Done") {
          self.onComplete()
        }.disabled(!self.dirty()))
    }
  }
  
  func onComplete() {
    ExerciseTemplate.createExerciseTemplateFor(
      name: self.name,
      desc: self.description,
      muscleGroups: self.selectedMuscleGroups.muscleGroups,
      exerciseType: self.exerciseType
    )
    self.isPresented.toggle()
  }
  
  func dirty() -> Bool {
    return !self.name.isEmpty && !self.description.isEmpty
  }
}

struct NewExercise_Previews: PreviewProvider {
  @State static var isModalPresented = true
  static var previews: some View {
    NewExercise(isPresented: $isModalPresented)
  }
  
}
