//
//  WorkoutRow.swift
//  IronNotes
//
//  Created by Stewart Avery on 7/21/19.
//  Copyright © 2019 Stewart Avery. All rights reserved.
//

import SwiftUI
import CoreData

struct WorkoutRowLabel: View {
  @Environment(\.colorScheme) var colorScheme: ColorScheme

  var workout: Workout
  
  var body: some View {
    VStack(alignment: .leading) {
      Text(workout.meta.name)
        .font(.headline)
      Text(workout.meta.desc)
        .font(.subheadline)
      Text(getWorkoutDate())
        .font(.subheadline)
        .foregroundColor(.gray)
    }.accentColor(colorScheme == .light ? Color.black : Color.white)
  }
  
  func getWorkoutDate() -> String {
    return "Last Workout: " +
      self.workout.dayDifference(
        from: self.workout.startTime
    )
  }
}

struct WorkoutRow: View {
  var workout: Workout

  var body: some View {
    HStack {
      RowImage(iconName: self.workout.meta.iconName)
      
      WorkoutRowLabel(workout: workout).padding(.leading, CGFloat(10))
    }
    .frame(height: 80)
  }
  
 
}

#if DEBUG
struct WorkoutRow_Previews: PreviewProvider {
  static var previews: some View {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let workout = Workout(context: context)
    let workoutMeta = WorkoutTemplate(context: context)
    workoutMeta.name = "Test"
    workoutMeta.iconName = "barbell"
    workoutMeta.desc = "Test Description"
    workout.meta = workoutMeta
    workout.startTime = Date()
    workout.routines = []
        
    return Group {
      WorkoutRow(workout: workout)
      WorkoutRow(workout: workout)
    }
  }
}
#endif
