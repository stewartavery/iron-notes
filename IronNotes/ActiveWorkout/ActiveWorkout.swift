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
    VStack() {
      WorkoutRow(workout: workout)
  
      List {
        ForEach(workout.routine) { exercise in
          Section(header: Text(exercise.meta.name)) {
            ForEach(exercise.sets) { exerciseSet in
              HStack {
                Text(String(exerciseSet.weight))
                Spacer()
                Text(String(exerciseSet.reps))
              }
            }
          }
        }
      }
    }
  }
  
  struct ActiveWorkout_Previews: PreviewProvider {
    static var previews: some View {
      ActiveWorkout(workout: workoutData[0])
    }
  }
}
