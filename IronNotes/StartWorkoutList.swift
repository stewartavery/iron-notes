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
            isFullScreenModalVisible.toggle()
          } label: {
            WorkoutRow(workoutTemplate: workoutTemplate)
          }
          
          // TODO: create workout on tap, save that workout in store, then use that workout to determine if fullScreenCover can open
          .fullScreenCover(
            isPresented: $isFullScreenModalVisible, // TODO: this logic is broken if there are multiple items, edit: or maybe not?
            content: {
              ActiveWorkout(
                stopwatchManager: stopwatchManager,
                keyboardMonitor: keyboardMonitor,
                workoutTemplate: workoutTemplate
              )
            }
          )
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
