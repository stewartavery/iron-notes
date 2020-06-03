//
//  NewWorkout.swift
//  IronNotes
//
//  Created by Stewart Avery on 2/16/20.
//  Copyright © 2020 Stewart Avery. All rights reserved.
//

import SwiftUI

struct NewWorkout: View {
  @Binding var isPresented: Bool
  
  @State var name: String = ""
  @State var description: String = ""
  @State var isAddExerciseVisible = false
  
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
          AddExercise(isPresented: self.$isAddExerciseVisible)
            .environment(\.managedObjectContext, AppDelegate.viewContext)
      })
        .navigationBarTitle(Text("New Workout"), displayMode: .inline)
        .navigationBarItems(leading:
          Button("Close") {
            self.isPresented.toggle()
          },trailing: Button("Done") {
            self.isPresented.toggle()
        })
        .onAppear(perform: resetTableView)
      
    }
  }
  func resetTableView() {
    UITableView.appearance().tableFooterView = UIView()
    UITableView.appearance().separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
  }
}

struct NewWorkout_Previews: PreviewProvider {
  @State static var isModalPresented = true
  static var previews: some View {
    NewWorkout(isPresented: $isModalPresented)
  }
}
