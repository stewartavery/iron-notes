//
//  WorkoutAction.swift
//  IronNotes
//
//  Created by Stewart Avery on 10/13/20.
//  Copyright © 2020 Stewart Avery. All rights reserved.
//

import SwiftUI


struct WorkoutAction: View {
  @Environment(\.colorScheme) var colorScheme: ColorScheme
  
  var title: String
  var icon: String
  var action: () -> Void
  
  
  var body: some View {
    Button {
      action()
    } label : {
      Label {
        Text(title)
      } icon: {
        Image(systemName: icon)
      }
    }.buttonStyle(WorkoutActionStyle(colorScheme: colorScheme))
  }
}

struct WorkoutAction_Previews: PreviewProvider {
  static var previews: some View {
    WorkoutAction(title: "Change Workout", icon: "note.text") {
      print("Test")
    }
  }
}
