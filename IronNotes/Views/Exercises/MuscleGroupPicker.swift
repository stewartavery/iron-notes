//
//  MuscleGroupPicker.swift
//  IronNotes
//
//  Created by Stewart Avery on 5/14/20.
//  Copyright © 2020 Stewart Avery. All rights reserved.
//

import SwiftUI

struct MultipleSelectionRow: View {
  var muscleGroup: MuscleGroup
  @Binding var unsavedGroups: [MuscleGroup]
  var action: () -> Void
  
  @Environment(\.colorScheme) var colorScheme: ColorScheme
  
  var body: some View {
    Button(action: self.action) {
      HStack {
        Text(self.muscleGroup.name)
        if self.unsavedGroups.contains(self.muscleGroup) {
          Spacer()
          Image(systemName: "checkmark").foregroundColor(.blue)
        }
      }.foregroundColor(colorScheme == .light ? Color.black : Color.white)
    }
  }
}

struct MuscleGroupPicker: View {
  @FetchRequest(entity: MuscleGroup.entity(),
                sortDescriptors: [NSSortDescriptor(keyPath: \MuscleGroup.name, ascending: true)
  ]) var muscleGroups: FetchedResults<MuscleGroup>
  
  @State private var unSavedMuscleGroups = [MuscleGroup]()
  @ObservedObject var selectedMuscleGroups: SelectedMuscleGroups
  
  init(_ selectedMuscleGroups: SelectedMuscleGroups) {
      self.selectedMuscleGroups = selectedMuscleGroups
  }
  
  var body: some View {
    List {
      Section(header: Text("APPLICABLE MUSCLE GROUPS")) {
        ForEach(muscleGroups, id: \.self) { muscleGroup in
          MultipleSelectionRow(muscleGroup: muscleGroup, unsavedGroups: self.$unSavedMuscleGroups) {
            if self.unSavedMuscleGroups.contains(muscleGroup) {
              self.unSavedMuscleGroups.removeAll(where: { $0 == muscleGroup })
            }
            else {
              self.unSavedMuscleGroups.append(muscleGroup)
            }
          }
        }
      }
    }
    .onAppear(perform: { self.unSavedMuscleGroups = self.selectedMuscleGroups.muscleGroups })
    .onDisappear(perform: { self.selectedMuscleGroups.muscleGroups = self.unSavedMuscleGroups})
    .listStyle(GroupedListStyle())
    .navigationBarTitle("Muscle Groups", displayMode: .inline)
  }
  
}

struct MuscleGroupPicker_Previews: PreviewProvider {
  @ObservedObject static var selectedMuscleGroups = SelectedMuscleGroups()
  
  static var previews: some View {
    MuscleGroupPicker(selectedMuscleGroups)
      .environment(\.managedObjectContext, AppDelegate.viewContext)
  }
}

