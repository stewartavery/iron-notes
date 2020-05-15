//
//  MuscleGroupPicker.swift
//  IronNotes
//
//  Created by Stewart Avery on 5/14/20.
//  Copyright © 2020 Stewart Avery. All rights reserved.
//

import SwiftUI

struct MultipleSelectionRow: View {
  var title: String
  var isSelected: Bool
  var action: () -> Void
  
  var body: some View {
    Button(action: self.action) {
      HStack {
        Text(self.title)
        if self.isSelected {
          Spacer()
          Image(systemName: "checkmark").foregroundColor(.blue)
        }
      }
    }.foregroundColor(Color.black)
  }
}

struct MuscleGroupPicker: View {
  @FetchRequest(entity: MuscleGroup.entity(),
                sortDescriptors: [NSSortDescriptor(keyPath: \MuscleGroup.name, ascending: true)
  ]) var muscleGroups: FetchedResults<MuscleGroup>
  
  @State private var unSavedMuscleGroups = [MuscleGroup]()
  @ObservedObject var selectedMuscleGroups: SelectedMuscleGroups
  
  var body: some View {
    List {
      Section(header: Text("APPLICABLE MUSCLE GROUPS")) {
        ForEach(muscleGroups, id: \.self) { muscleGroup in
          MultipleSelectionRow(title: muscleGroup.name, isSelected: self.unSavedMuscleGroups.contains(muscleGroup)) {
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
    .listStyle(GroupedListStyle())
    .navigationBarTitle("Muscle Groups", displayMode: .inline)
//    .navigationBarItems(trailing:
//      Button(action: {
//        self.selectedMuscleGroups.muscleGroups = self.unSavedMuscleGroups
//      }) {
//        Text("Ok")
//      }
//    )
  }
  
}

struct MuscleGroupPicker_Previews: PreviewProvider {
  @ObservedObject static var selectedMuscleGroups = SelectedMuscleGroups()
  
  static var previews: some View {
    MuscleGroupPicker(selectedMuscleGroups: selectedMuscleGroups)
      .environment(\.managedObjectContext, AppDelegate.viewContext)
  }
}

