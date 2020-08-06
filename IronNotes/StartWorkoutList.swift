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
  @FetchRequest(entity: Workout.entity(), sortDescriptors: []) var workouts: FetchedResults<Workout>
  @State var isCreateViewVisible = false
  
  init() {
    UITableView.appearance().separatorStyle = .none
    UITableView.appearance().separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 40)
  }
  
  var body: some View {
    NavigationView {
      List {
        ForEach(workouts, id: \.self) { workout in
          NavigationLink(destination: ActiveWorkout(workout: workout)) {
            WorkoutRow(workout: workout).listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))

          }
        }
        Button {
          self.isCreateViewVisible.toggle()
        } label: {
          AddWorkoutRow()
        }
      }
      .listStyle(DefaultListStyle())
      .sheet(isPresented: $isCreateViewVisible, content: { NewWorkout(isPresented: self.$isCreateViewVisible) })
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

