//
//  WorkoutMetaEditor.swift
//  IronNotes
//
//  Created by Stewart Avery on 8/23/20.
//  Copyright © 2020 Stewart Avery. All rights reserved.
//

import SwiftUI

struct WorkoutMetaEditor: View {
  @Environment(\.presentationMode) var presentationMode
  @Environment(\.managedObjectContext) var moc
  @ObservedObject var workout: Workout
  
  @State private var workoutName: String
  @State private var workoutDescription: String
  
  init(workout: Workout) {
    self.workout = workout
    self._workoutName = State<String>(initialValue: workout.meta.name)
    self._workoutDescription = State<String>(initialValue: workout.meta.desc)
  }
  
  var body: some View {
    NavigationView {
      Form {
        Section(header: Text("Workout Details")) {
          TextField("Workout name", text: $workoutName)
          TextField("Description", text: $workoutDescription)
        }
      }
      .listStyle(InsetGroupedListStyle())
      .navigationBarTitle(Text("Workout Details"), displayMode: .inline)
      .toolbar {
        ToolbarItem(placement: .primaryAction) {
          Button("Done") {
            presentationMode.wrappedValue.dismiss()
          }
        }
      }
    }
  }
  
}

struct WorkoutMetaEditor_Previews: PreviewProvider {
  static var previews: some View {
    WorkoutMetaEditor(workout: IronNotesModelFactory.getWorkout())
      .environmentObject(IronNotesModelFactory.getWorkout())
      .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
  }
}
