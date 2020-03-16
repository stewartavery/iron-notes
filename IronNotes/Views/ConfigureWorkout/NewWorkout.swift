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
      VStack {
        HStack {
          Button(action: {self.isPresented.toggle()})  {
            Text("Cancel")
          }
          Spacer()
          Text("New Workout")
            .fontWeight(.bold)
          Spacer()
          Button(action: {self.isPresented.toggle()})  {
            Text("Done")
              .foregroundColor(Color.blue)
              .fontWeight(.bold)
          }
        }.padding()
          .padding(.bottom, 0)
        Spacer()
        Divider()
      }.frame(height: 45)
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
