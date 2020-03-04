//
//  ActiveWorkout.swift
//  IronNotes
//
//  Created by Stewart Avery on 2/16/20.
//  Copyright © 2020 Stewart Avery. All rights reserved.
//

import SwiftUI
import CoreData

struct ActiveWorkout: View {
  var workout: Workout
  
  var body: some View {
  List {
    ForEach(workout.routinesArray, id: \.self) { exerciseDetail in
      Group {
        Text(exerciseDetail.wrappedName)
        ExerciseEditor(exerciseDetail: exerciseDetail)
      }
    }
  }
  .navigationBarTitle(Text(workout.wrappedName), displayMode: .large)
  }
}
  
//  struct ActiveWorkout_Previews: PreviewProvider {
//    static var previews: some View {
//      EmptyView()
//    }
//  }


