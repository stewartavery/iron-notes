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
  var body: some View {
    NavigationView {
      VStack {
        Form {
          Section {
            TextField("Workout name", text: $name)
            TextField("Description", text: $description)
          }
          Section {
            TextField("Other", text: $name)
          }
        }
      }
      .navigationBarTitle(Text("New Workout"), displayMode: .inline)
      .navigationBarItems(leading:
        Button("Close") {
          self.isPresented.toggle()
        },trailing: Button("Done") {
          self.isPresented.toggle()
      })
    }
  }
}

struct NewWorkout_Previews: PreviewProvider {
  @State static var isModalPresented = true
  static var previews: some View {
    NewWorkout(isPresented: $isModalPresented)
  }
}
