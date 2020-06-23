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


  var body: some View {
    NavigationView {
      List {
        ForEach(workouts, id: \.self) { workout in
          NavigationLink(destination: ActiveWorkout(workout: workout)) {
            WorkoutRow(workout: workout)
          }
        }
        Button(action: {
          self.isCreateViewVisible.toggle()
        }) { AddWorkoutRow() }
      }
      .sheet(isPresented: $isCreateViewVisible, content: { NewWorkout(isPresented: self.$isCreateViewVisible) })
//      .onAppear(perform: setupCustomTableView)
      .navigationBarTitle("Workouts", displayMode: .large)
      .accentColor(Color.green)
//      .onDisappear(perform: resetTableView)
    }
  }
  
//  func setupCustomTableView() {
//    UITableView.appearance().tableFooterView = UIView()
//    UITableView.appearance().separatorInset = UIEdgeInsets(top: 0, left: 135, bottom: 0, right: 0)
//  }
//
//  func resetTableView() {
//    UITableView.appearance().tableFooterView = UIView()
//    UITableView.appearance().separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
//  }
}

#if DEBUG
struct StartWorkoutList_Preview : PreviewProvider {
  static var previews: some View {
    StartWorkoutList()
      .environment(\.managedObjectContext, AppDelegate.viewContext)
  }
}
#endif

