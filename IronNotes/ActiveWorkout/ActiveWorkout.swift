//
//  ActiveWorkout.swift
//  IronNotes
//
//  Created by Stewart Avery on 2/16/20.
//  Copyright © 2020 Stewart Avery. All rights reserved.
//

import SwiftUI

struct ActiveWorkout: View {
  var workout: Workout
  
  var body: some View {
    List {
      ForEach(workout.routines, id: \.exerciseDetailId) { exercise in
        ExerciseEditor(exercise: exercise)
      }
    }
    .navigationBarTitle(Text(workout.name ?? "Test workout"), displayMode: .large)
  }
  
//  struct ActiveWorkout_Previews: PreviewProvider {
//    static var previews: some View {
//      EmptyView()
//    }
//  }
}

