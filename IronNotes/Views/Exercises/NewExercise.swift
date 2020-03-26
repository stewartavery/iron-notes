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
  
  @State private var exerciseType: ExerciseType = ExerciseType.barbell
  @State private var muscleGroup: MuscleGroup = MuscleGroup.abdominals
  
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
            Picker(selection: $muscleGroup, label: Text("Muscle Group")) {
              ForEach(MuscleGroup.allCases, id: \.self) { m in
                Text(m.rawValue)
              }
            }
          }
        }.onAppear() {
          UITableView.appearance().tableFooterView = UIView()
          UITableView.appearance().separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        }
      }
      .navigationBarTitle(Text("New Exercise"), displayMode: .inline)
      .navigationBarItems(leading:
        Button("Close") {
          self.isPresented.toggle()
        },trailing: Button("Done") {
          self.isPresented.toggle()
      })
    }
  }
}

struct NewExercise_Previews: PreviewProvider {
  @State static var isModalPresented = true
  static var previews: some View {
    NewExercise(isPresented: $isModalPresented)
    
  }
  
}
