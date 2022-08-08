//
//  TopToolbarContent.swift
//  IronNotes
//
//  Created by Stewart Avery on 9/9/20.
//  Copyright © 2020 Stewart Avery. All rights reserved.
//

import SwiftUI

struct TopToolbarContent: View {
  @Binding var workoutSheet: WorkoutSheet?
  
  var body: some View {
      Menu {
        Button {
          workoutSheet = .workout
        } label: {
          Label("Change Workout", systemImage: "note.text")
        }
        Button {
          workoutSheet = .exercises
        } label: {
          Label("Edit Exercises", systemImage: "pencil")
        }
        Button {
          print("remove")
        } label: {
          Label("Remove Workout", systemImage: "trash")
        }.foregroundColor(Color.red)
      } label: {
        Image(systemName: "ellipsis.circle")
      }
  }
}

struct TopToolbarContent_Previews: PreviewProvider {
  @State static var workoutSheet: WorkoutSheet? = nil
  static var previews: some View {
    TopToolbarContent(workoutSheet: $workoutSheet)
      .environmentObject(KeyboardMonitor())
  }
}
