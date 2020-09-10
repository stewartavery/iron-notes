//
//  WorkoutDescription.swift
//  IronNotes
//
//  Created by Stewart Avery on 7/28/20.
//  Copyright © 2020 Stewart Avery. All rights reserved.
//

import SwiftUI

struct WorkoutButton: View {
  @Environment(\.colorScheme) var colorScheme: ColorScheme
  
  var label: String
  var systemImage: String
  
  var body: some View {
    Label(self.label, systemImage: self.systemImage)
      .foregroundColor(Color.orange)
      .font(.headline)
    
  }
}


struct WorkoutDescription: View {
  @ObservedObject var workout: Workout
  @Binding var isEditing: Bool
  @EnvironmentObject var stopwatchManager: StopwatchManager
  
  var body: some View {
    Button {
      stopwatchManager.start(workout)
    } label: {
      WorkoutButton(label: "Start", systemImage: "play.fill")
    }
  }
}

#if DEBUG
struct WorkoutDescription_Previews: PreviewProvider {
  @State static var isEditing = true
  
  static var previews: some View {
    return
      List {
        Section {
          WorkoutDescription(
            workout: IronNotesModelFactory.getWorkout(),
            isEditing: $isEditing
          )
          Text("Hey")
        }
      }.listStyle(InsetGroupedListStyle())
      .environment(\.colorScheme, .dark)
      .environmentObject(StopwatchManager())
  }
}
#endif
