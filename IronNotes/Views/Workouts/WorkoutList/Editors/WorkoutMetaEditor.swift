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
  @State private var color =
      Color(.sRGB, red: 0.98, green: 0.9, blue: 0.2)
  
//  var reps: Binding<String> {
//    return Binding<String>(get: {
//      String(exerciseSet.reps)
//    }, set: { value in
//      exerciseSet.reps = Int16(value) ?? 0
//    })
//  }
  
  init(workout: Workout) {
    self.workout = workout
    self._workoutName = State<String>(initialValue: workout.meta?.wrappedName ?? "")
    self._workoutDescription = State<String>(initialValue: workout.meta?.wrappedDesc ?? "")
  }
  
  var body: some View {
    NavigationView {
      Form {
        Section(header: Text("Workout Details")) {
          TextField("Workout name", text: $workoutName)
          TextField("Description", text: $workoutDescription)
        }
        Section {
          ColorPicker("Alignment Guides", selection: $color)
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
