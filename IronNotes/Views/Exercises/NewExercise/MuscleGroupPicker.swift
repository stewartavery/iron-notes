//
//  MuscleGroupPicker.swift
//  IronNotes
//
//  Created by Stewart Avery on 5/14/20.
//  Copyright © 2020 Stewart Avery. All rights reserved.
//

import SwiftUI

struct MultipleSelectionRow: View {
  @Binding var unsavedMuscleGroups: [MuscleGroup]
  
  var muscleGroup: MuscleGroup
  
  var body: some View {
    Button(action: handleSelection) {
      HStack {
        Text(muscleGroup.name ?? "")
          .font(.body)
        
        if unsavedMuscleGroups.contains(muscleGroup) {
          Spacer()
          Image(systemName: "checkmark").foregroundColor(.blue)
        }
      }.foregroundColor(Color(.label))
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
          MultipleSelectionRow(unsavedMuscleGroups: $unsavedMuscleGroups, muscleGroup: muscleGroup)
        }
      }
    }
    .onAppear(perform: { self.unsavedMuscleGroups = self.selectedMuscleGroups.muscleGroups })
    .onDisappear(perform: {
      self.selectedMuscleGroups.muscleGroups = self.unsavedMuscleGroups
    })
    .listStyle(GroupedListStyle())
    .navigationBarTitle("Muscle Groups", displayMode: .inline)
  }
  
}

#if DEBUG
struct MuscleGroupPicker_Previews: PreviewProvider {
  @ObservedObject static var selectedMuscleGroups = SelectedMuscleGroups()
  
  static var previews: some View {
    NavigationView {
      MuscleGroupPicker(selectedMuscleGroups: selectedMuscleGroups)
        .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
    }
  }
}
#endif
