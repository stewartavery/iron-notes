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
  @Binding var unsavedMuscleGroups: [MuscleGroup]
  @Environment(\.colorScheme) var colorScheme: ColorScheme
  
  var body: some View {
    Button(action: handleSelection) {
      HStack {
        Text(self.muscleGroup.name)
        if self.unsavedMuscleGroups.contains(self.muscleGroup) {
          Spacer()
          Image(systemName: "checkmark").foregroundColor(.blue)
        }
      }.foregroundColor(colorScheme == .light ? Color.black : Color.white)
    }
  }
  
  func handleSelection() {
    if self.unsavedMuscleGroups.contains(muscleGroup) {
      self.unsavedMuscleGroups.removeAll(where: { $0 == muscleGroup })
    }
    else {
      self.unsavedMuscleGroups.append(muscleGroup)
    }
  }
}

struct MuscleGroupPicker: View {
  @FetchRequest(entity: MuscleGroup.entity(),
                sortDescriptors: [NSSortDescriptor(keyPath: \MuscleGroup.name, ascending: true)
  ]) var muscleGroups: FetchedResults<MuscleGroup>
  
  @State private var unsavedMuscleGroups = [MuscleGroup]()
  @ObservedObject var selectedMuscleGroups: SelectedMuscleGroups
  
  var body: some View {
    List {
      Section(header: Text("APPLICABLE MUSCLE GROUPS").padding(.top, 20)) {
        ForEach(muscleGroups, id: \.self) { muscleGroup in
          MultipleSelectionRow(muscleGroup: muscleGroup, unsavedMuscleGroups: self.$unsavedMuscleGroups)
        }
      }
    }
    .onAppear(perform: { self.unsavedMuscleGroups = self.selectedMuscleGroups.muscleGroups })
    .onDisappear(perform: {
      self.selectedMuscleGroups.muscleGroups = self.unsavedMuscleGroups
      print("disappearing!")
    })
      .listStyle(GroupedListStyle())
      .navigationBarTitle("Muscle Groups", displayMode: .inline)
  }
  
}

struct MuscleGroupPicker_Previews: PreviewProvider {
  @ObservedObject static var selectedMuscleGroups = SelectedMuscleGroups()
  
  static var previews: some View {
    NavigationView {
      MuscleGroupPicker(selectedMuscleGroups: selectedMuscleGroups)
        .environment(\.managedObjectContext, AppDelegate.viewContext)
    }
  }
}
