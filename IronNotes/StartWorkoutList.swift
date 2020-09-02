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
    entity: Workout.entity(),
    sortDescriptors: []
  ) var workouts: FetchedResults<Workout>
  @EnvironmentObject var keyboardMonitor: KeyboardMonitor
  @EnvironmentObject var stopwatchManager: StopwatchManager


  @State var isCreateViewVisible = false
  @State var isFullScreenModalVisible = false
  
  
  var body: some View {
    NavigationView {
      List {
        ForEach(workouts, id: \.self) { workout in
          Button {
            isFullScreenModalVisible.toggle()
          } label: {
            WorkoutRow(workout: workout)
          }
          .fullScreenCover(
            isPresented: $isFullScreenModalVisible,
            content: { ActiveWorkout(stopwatchManager: stopwatchManager, keyboardMonitor: keyboardMonitor)
              .environmentObject(workout)
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
