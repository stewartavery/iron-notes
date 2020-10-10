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
  @EnvironmentObject var workoutStore: WorkoutStore
  
  var workoutTemplate: WorkoutTemplate
  
  var workout: Workout? {
    return workoutStore.items
      .first(where: {
        $0.meta == workoutTemplate
      })
  }
  
  var body: some View {
    return VStack(alignment: .leading) {
      Text(workoutTemplate.name)
        .font(.headline)
      //      Text(workoutTemplate.desc)
      //        .font(.subheadline)
      if let unwrappedWorkout = workout {
        Text(getWorkoutDate(workout: unwrappedWorkout))
          .font(.subheadline)
          .foregroundColor(.gray)
      } else {
        Text("Last Workout: Never")
          .font(.subheadline)
          .foregroundColor(.gray)
      }
      
    }.accentColor(colorScheme == .light ? Color.black : Color.white)
    
  }
  
  func getWorkoutDate(workout: Workout) -> String {
    return "Last Workout: " +
      workout.dayDifference(
        from: workout.wrappedStartTime
      )
  }
}

struct WorkoutRow: View {
  var workoutTemplate: WorkoutTemplate
  
  var body: some View {
    WorkoutRowLabel(workoutTemplate: workoutTemplate)
      .padding(.leading, CGFloat(10))
      .frame(height: 65)
  }
}

#if DEBUG
struct WorkoutRow_Previews: PreviewProvider {
  static var previews: some View {
    let context = PersistenceController.shared.container.viewContext
    let workout = Workout(context: context)
    let workoutMeta = WorkoutTemplate(context: context)
    workoutMeta.name = "Test"
    workoutMeta.iconName = "barbell"
    workoutMeta.desc = "Test Description"
    workout.meta = workoutMeta
    workout.startTime = Date()
    workout.routines = []
    
    
    return Group {
      WorkoutRow(workoutTemplate: workoutMeta)
        .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
    }
    
    
  }
}
#endif
