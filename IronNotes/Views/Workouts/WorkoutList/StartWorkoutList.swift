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
  @State var selectedTemplate: WorkoutTemplate? = nil
  
  var body: some View {
    NavigationView {
      List {
        ForEach(workoutTemplateStore.items) { workoutTemplate in
          Button {
            if workoutStore.primaryWorkout == nil {
              workoutStore.setupPrimaryWorkout(with: workoutTemplate)
            }
            selectedTemplate = workoutTemplate
          } label: {
            WorkoutRow(workoutTemplate: workoutTemplate)
          }
        }
        Button {
          isCreateViewVisible.toggle()
        } label: {
          AddWorkoutRow()
        }
        
      }
      .listStyle(InsetGroupedListStyle())
      .sheet(
        isPresented: $isCreateViewVisible,
        content: {
          NewWorkout(isPresented: self.$isCreateViewVisible)
        })
      .fullScreenCover(
        item: $selectedTemplate,
        onDismiss: dismissModal) { _ in
        switch workoutStore.primaryWorkout {
        case .some(let workout):
          ActiveWorkout(
            keyboardMonitor: keyboardMonitor,
            workout: workout,
            workoutStore: workoutStore
          ).environment(\.scenePhase, scenePhase)
        default:
          EmptyView()
        }
       
      }
      .navigationBarTitle("Workouts")
    }
  }
  
  private func dismissModal() -> Void {
    switch (workoutStore.workoutStatus, workoutStore.primaryWorkout)  {
    case (.stopped, .some(let workout)) where workout.duration > 0:
      workoutStore.finishPrimaryWorkout()
    case (.stopped, .some(let workout)):
      workout.deleteWorkout()
      workoutStore.finishPrimaryWorkout()
    default:
      break
    }
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
