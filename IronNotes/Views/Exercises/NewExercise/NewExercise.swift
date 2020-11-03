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
  @Environment(\.managedObjectContext) var moc
  
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
              .font(.body)
            TextField("Description", text: $description)
              .font(.body)
          }
          Section {
            Picker(selection: $exerciseType, label:
                    Text("Type of Exercise").font(.body)
            ) {
              ForEach(ExerciseType.allCases) { e in
                Text(e.rawValue)
                  .font(.body)
              }
            }
          }
          Section {
            NavigationLink(destination: MuscleGroupPicker(selectedMuscleGroups: selectedMuscleGroups).environment(\.managedObjectContext, moc)) {
              Text("Muscle Groups")
            }
          }
          .font(.body)
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
      name: name,
      desc: description,
      muscleGroups: selectedMuscleGroups.muscleGroups,
      exerciseType: exerciseType
    )
    self.isPresented.toggle()
  }
  
  func dirty() -> Bool {
    return !self.name.isEmpty && !self.description.isEmpty
  }
}

#if DEBUG
struct NewExercise_Previews: PreviewProvider {
  @State static var isModalPresented = true
  static var previews: some View {
    NewExercise(isPresented: $isModalPresented)
  }
}
#endif
