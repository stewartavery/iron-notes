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
      ForEach(self.workout.routines, id: \.exerciseId) { exercise in
        Section(header: Text(exercise.meta.name ?? "")) {
          ForEach(exercise.sets, id: \.exerciseSetId) { exerciseSet in
            HStack {
              Text(String(exerciseSet.weight ?? 0))
              Spacer()
              Text(String(exerciseSet.reps ?? 3))
            }
          }
        }
      }
    }
//    .navigationBarTitle(Text(self.workout.name ?? "Test workout"), displayMode: .large)
  }
  
  struct ActiveWorkout_Previews: PreviewProvider {
    static var previews: some View {
      EmptyView()
    }
  }
}
