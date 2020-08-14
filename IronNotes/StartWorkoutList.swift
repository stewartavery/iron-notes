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
  @State var isCreateViewVisible = false
  
  
  var body: some View {
    NavigationView {
      List {
        ForEach(workouts, id: \.self) { workout in
            NavigationLink(destination: ActiveWorkout().environmentObject(workout)) {
              WorkoutRow(workout: workout)
            }
          
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
      .environment(\.managedObjectContext, AppDelegate.viewContext)
  }
}
#endif
