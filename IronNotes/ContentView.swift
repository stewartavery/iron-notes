//
//  StartWorkoutList.swift
//  IronNotes
//
//  Created by Stewart Avery on 7/3/19.
//  Copyright © 2019 Stewart Avery. All rights reserved.
//

import SwiftUI

struct StartWorkoutList : View {
  var workouts: [Workout]
    
  var body: some View {
    NavigationView {
      List {
        ForEach(workouts) { workout in
          WorkoutRow(workout: workout)
        }
        // Think I'm going to remove the add workout row, doesn't make sense to optimize for
        // this type of control
        AddWorkoutRow()
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

