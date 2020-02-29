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
  
//  var workouts: [Workout]
  
  var body: some View {
    NavigationView {
      List {
        ForEach(workouts) { workout in
          NavigationLink(destination: ActiveWorkout(workout: workout)) {
            WorkoutRow(workout: workout)
          }
        }
        
        NavigationLink(destination: NewWorkout()) {
          AddWorkoutRow()
        }
      }
      .navigationBarTitle("Start Your Workout", displayMode: .large)
      .accentColor(Color.green)
    }
  }
}

#if DEBUG
struct StartWorkoutuList_Preview : PreviewProvider {
  static var previews: some View {
    StartWorkoutList(workouts: workoutData)
  }
}
#endif

