//
//  StartWorkoutList.swift
//  IronNotes
//
//  Created by Stewart Avery on 7/3/19.
//  Copyright © 2019 Stewart Avery. All rights reserved.
//

import SwiftUI

struct StartWorkoutButton: View {
  @EnvironmentObject var workoutStore: WorkoutStore
  
  var template: WorkoutTemplate

  var body: some View {
    Button {
      workoutStore.workoutInput = .template(template)
    } label: {
      SummaryRow(
        title: template.wrappedName,
        description: template.wrappedDesc,
        color: .red
      )
    }
  }
}

struct StartWorkoutList : View {
  @EnvironmentObject var workoutStore: WorkoutStore
  
  @State var isCreateViewVisible = false
  
  var activeWorkoutHeader: some View {
    Text("Active Workout")
      .font(.headline)
      .textCase(nil)
  }
  
  var body: some View {
    List {
      Group {
        switch (workoutStore.activeWorkout) {
        case (.some(let activeWorkout)) where activeWorkout.status == .running:
          if let template = activeWorkout.workout.meta {
            Section(header: activeWorkoutHeader) {
              StartWorkoutButton(template: template)
            }
          }
        default:
          EmptyView()
        }
      }
      Section {
        ForEach(workoutStore.nonActiveWorkoutTemplates) { template in
          StartWorkoutButton(template: template)
        }
        Button {
          workoutStore.workoutInput = .noTemplate
        } label: {
          AddWorkoutRow()
        }
      }
      
    }
    .listStyle(InsetGroupedListStyle())
    .navigationBarTitle("Workouts", displayMode: .inline)
  }
}

#if DEBUG
struct StartWorkoutList_Preview : PreviewProvider {
  static var previews: some View {
    StartWorkoutList()
      .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
      .environmentObject(WorkoutStore(managedObjectContext: PersistenceController.shared.container.viewContext))
  }
}
#endif
