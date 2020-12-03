//
//  StartWorkoutList.swift
//  IronNotes
//
//  Created by Stewart Avery on 7/3/19.
//  Copyright © 2019 Stewart Avery. All rights reserved.
//

import SwiftUI



struct StartWorkoutList : View {
  @Environment(\.managedObjectContext) var moc
  @Environment(\.scenePhase) private var scenePhase
  
  @EnvironmentObject var workoutStore: WorkoutStore
  @EnvironmentObject var workoutTemplateStore: WorkoutTemplateStore
  @EnvironmentObject var keyboardMonitor: KeyboardMonitor
  
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
          if let meta = activeWorkout.workout.meta {
            Section(header: activeWorkoutHeader) {
              Button {
                workoutStore.workoutInput = .template(meta)
              } label: {
                WorkoutRow(workoutTemplate: meta)
              }
            }
          }
        default:
          EmptyView()
        }
      }
      Section {
        ForEach(workoutStore.nonActiveWorkoutTemplates) { workoutTemplate in
          Button {
            workoutStore.workoutInput = .template(workoutTemplate)
          } label: {
            WorkoutRow(workoutTemplate: workoutTemplate)
          }
        }
        Button {
          workoutStore.workoutInput = .noTemplate
        } label: {
          AddWorkoutRow()
        }
      }
      
    }
    .listStyle(InsetGroupedListStyle())
    .fullScreenCover(
      item: $workoutStore.workoutInput,
      onDismiss: workoutStore.finishWorkout) { _ in
      switch workoutStore.activeWorkout {
      case .some(let activeWorkout):
        ActiveWorkoutEditor(
          keyboardMonitor: keyboardMonitor,
          activeWorkout: activeWorkout
        ).environment(\.scenePhase, scenePhase)
      case .none:
        EmptyView()
      }
      
    }
    .navigationBarTitle("Workouts", displayMode: .inline)
  }
}

#if DEBUG
struct StartWorkoutList_Preview : PreviewProvider {
  static var previews: some View {
    StartWorkoutList()
      .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
      .environmentObject(KeyboardMonitor())
      .environmentObject(StopwatchManager())
      .environmentObject(WorkoutTemplateStore(managedObjectContext: PersistenceController.shared.container.viewContext))
      .environmentObject(WorkoutStore(managedObjectContext: PersistenceController.shared.container.viewContext))
  }
}
#endif
