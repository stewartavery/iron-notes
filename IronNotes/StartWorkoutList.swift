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
  
  @EnvironmentObject var workoutStore: WorkoutStore
  @EnvironmentObject var workoutTemplateStore: WorkoutTemplateStore
  @EnvironmentObject var keyboardMonitor: KeyboardMonitor
  @EnvironmentObject var stopwatchManager: StopwatchManager
  
  @State var isCreateViewVisible = false
  @State var isFullScreenModalVisible = false
  
  var body: some View {
    NavigationView {
      List {
        ForEach(workoutTemplateStore.items, id: \.self) { workoutTemplate in
          Button {
            workoutStore.setupPrimaryWorkout(with: workoutTemplate)
            isFullScreenModalVisible.toggle()
          } label: {
            WorkoutRow(workoutTemplate: workoutTemplate)
          }
          .fullScreenCover(item: $workoutStore.primaryWorkout) { workout in
              ActiveWorkout(
                stopwatchManager: stopwatchManager,
                keyboardMonitor: keyboardMonitor,
                workout: workout
              )
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
      .navigationBarTitle("Workouts")
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
