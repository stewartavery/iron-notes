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
  @FetchRequest(
    entity: WorkoutTemplate.entity(),
    sortDescriptors: []
  ) var workoutTemplates: FetchedResults<WorkoutTemplate>
  @EnvironmentObject var keyboardMonitor: KeyboardMonitor
  @EnvironmentObject var stopwatchManager: StopwatchManager
  


  @State var isCreateViewVisible = false
  @State var isFullScreenModalVisible = false
  
  
  var body: some View {
    NavigationView {
      List {
        ForEach(workoutTemplates, id: \.self) { workoutTemplate in
          Button {
            isFullScreenModalVisible.toggle()
          } label: {
            WorkoutRow(workoutTemplate: workoutTemplate)
          }
          .fullScreenCover(
            isPresented: $isFullScreenModalVisible,
            content: { ActiveWorkout(stopwatchManager: stopwatchManager, keyboardMonitor: keyboardMonitor, workoutTemplate: workoutTemplate)
            }
          )
        }
        Button {
          self.isCreateViewVisible.toggle()
        } label: {
          AddWorkoutRow()
        }
        
      }
      .listStyle(InsetGroupedListStyle())
      .sheet(isPresented: $isCreateViewVisible,
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
  }
}
#endif
