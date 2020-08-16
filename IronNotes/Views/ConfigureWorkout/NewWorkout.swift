//
//  NewWorkout.swift
//  IronNotes
//
//  Created by Stewart Avery on 2/16/20.
//  Copyright © 2020 Stewart Avery. All rights reserved.
//

import SwiftUI

struct NewWorkout: View {
  @Environment(\.managedObjectContext) var moc
  @Binding var isPresented: Bool
  
  @State var workout: Workout = Workout(context: AppDelegate.viewContext)
  @State var name: String = ""
  @State var description: String = ""
  @State var isAddExerciseVisible = false
  @State var exercises: [ExerciseTemplate] = []
  
  var body: some View {
    NavigationView {
      VStack {
        Form {
          Section {
            TextField("Workout name", text: $name)
            TextField("Description", text: $description)
          }
          List {
            Button(action: {
              self.isAddExerciseVisible.toggle()
            }) {
              HStack {
                Image(systemName: "plus.circle.fill").foregroundColor(Color.green)
                Text("Add Exercise").foregroundColor(Color.orange).padding(.leading, 10)
              }
            }
          }
        }
      }
      .sheet(
        isPresented: $isAddExerciseVisible,
        content: {
          ExerciseEditor(
            workout: workout,
            isPresented: self.$isAddExerciseVisible
          )
        })
      .navigationBarTitle(Text("New Workout"), displayMode: .inline)
      .navigationBarItems(
        leading: Button("Close") {
          self.isPresented.toggle()
        },
        trailing: Button("Done") {
          self.isPresented.toggle()
        })
    }
  }
}

#if DEBUG
struct NewWorkout_Previews: PreviewProvider {
  @State static var isModalPresented = true
  static var previews: some View {
    NewWorkout(isPresented: $isModalPresented)
  }
}
#endif
