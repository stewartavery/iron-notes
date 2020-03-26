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
    VStack {
      ModalHeader(isPresented: $isPresented, title: "New Workout")
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
  }
}

struct NewWorkout_Previews: PreviewProvider {
  @State static var isModalPresented = true
  static var previews: some View {
    NewWorkout(isPresented: $isModalPresented)
  }
}
