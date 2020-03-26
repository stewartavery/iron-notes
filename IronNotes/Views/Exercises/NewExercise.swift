//
//  NewWorkout.swift
//  IronNotes
//
//  Created by Stewart Avery on 3/25/20.
//  Copyright © 2020 Stewart Avery. All rights reserved.
//

import SwiftUI


struct NewExercise: View {
  @Binding var isPresented: Bool
  
  @State var name: String = ""
  @State var description: String = ""
  
  @State private var selectedExerciseType = -1
  @State private var selectedMuscleGroup = -1
  
  var exerciseTypeList = ["Barbell", "Dumbbell", "Machine"]
  
  var muscleGroupList = ["Abdominals", "Abductors", "Adductors", "Biceps", "Calves", "Chest", "Forearms", "Glutes", "Hamstrings", "Lats", "Lower Back", "Middle Back", "Neck", "Quadriceps", "Shoulders", "Traps", "Triceps"]
  
  var body: some View {
    VStack {
      ModalHeader(isPresented: $isPresented, title: "New Exercise")
      Form {
        Section {
          TextField("Exercise name", text: $name)
          TextField("Description", text: $description)
        }
        Section {
          Picker(selection: $selectedExerciseType, label: Text("Type of Exercise")) {
            ForEach(0..<exerciseTypeList.count) {
              Text(self.exerciseTypeList[$0])
            }
          }
        }
        Section {
          Picker(selection: $selectedMuscleGroup, label: Text("Muscle Group")) {
            ForEach(0..<muscleGroupList.count) {
              Text(self.muscleGroupList[$0])
            }
          }
        }
      }
    }
    
  }
}

struct NewExercise_Previews: PreviewProvider {
  @State static var isModalPresented = true
  static var previews: some View {
    NavigationView {
      
      NewExercise(isPresented: $isModalPresented)
    }
  }
  
}
