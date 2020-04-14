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
        ForEach(workouts, id: \.id) { workout in
          NavigationLink(destination: ActiveWorkout(workout: workout)) {
            WorkoutRow(workout: workout)
          }
          .listRowInsets(EdgeInsets(top: 23, leading: 0, bottom: 0, trailing: 0))
        }
        
        Button(action: {
          self.isCreateViewVisible.toggle()
        }) { AddWorkoutRow() }
      }
      .sheet(isPresented: $isCreateViewVisible, content: { NewExercise(isPresented: self.$isCreateViewVisible) })
      .onAppear() {
        UITableView.appearance().tableFooterView = UIView()
        UITableView.appearance().separatorInset = UIEdgeInsets(top: 0, left: 115, bottom: 0, right: 0)
      }
      .navigationBarTitle("Start Your Workout", displayMode: .large)
      .accentColor(Color.green)
    }
  }
}

#if DEBUG
struct StartWorkoutList_Preview : PreviewProvider {
  static var previews: some View {
    
    StartWorkoutList().environment(\.managedObjectContext, AppDelegate.viewContext).onAppear {
      //      let workout = Workout(context: AppDelegate.viewContext)
      
      //      workout.name = "Test Workout"
      //      workout.desc = "Really good workout!"
      //      workout.iconName = "barbell"
      //      workout.lastWorkoutDate = Date()
      //
      //      let exerciseDetail = ExerciseDetail(context: AppDelegate.viewContext)
      //      exerciseDetail.name = "Test"
      //      exerciseDetail.exerciseDetailIndex = 0
      //
      //      let exerciseSet = ExerciseSet(context: AppDelegate.viewContext)
      //      exerciseSet.exerciseSetIndex = 0
      //      exerciseSet.reps = 3
      //      exerciseSet.weight = 2
      //      exerciseDetail.addToSets(exerciseSet)
      //
      //      let exerciseSet5 = ExerciseSet(context: AppDelegate.viewContext)
      //      exerciseSet.exerciseSetIndex = 0
      //      exerciseSet.reps = 3
      //      exerciseSet.weight = 2
      //      exerciseDetail.addToSets(exerciseSet5)
      //
      //      workout.addToRoutines(exerciseDetail)
      //
      //      let exerciseDetail2 = ExerciseDetail(context: AppDelegate.viewContext)
      //      exerciseDetail2.name = "Test 2"
      //      exerciseDetail2.exerciseDetailIndex = 1
      //
      //      let exerciseSet2 = ExerciseSet(context: AppDelegate.viewContext)
      //      exerciseSet2.exerciseSetIndex = 1
      //      exerciseSet2.reps = 5
      //      exerciseSet2.weight = 39
      //      exerciseDetail2.addToSets(exerciseSet2)
      //
      //      workout.addToRoutines(exerciseDetail2)
      
    }
    
  }
}
#endif

