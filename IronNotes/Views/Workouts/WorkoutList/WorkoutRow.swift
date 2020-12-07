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
  @EnvironmentObject var workoutStore: WorkoutStore
  
  var workoutTemplate: WorkoutTemplate
  
  var workout: Workout? {
    return workoutStore.workouts
      .first(where: {
        $0.meta == workoutTemplate
      })
  }
  
  var description: String {
    switch workout {
    case .some(let workout):
      return getWorkoutDate(workout: workout)
    case .none:
      return "Last Workout: Never"
    }
  }
  
  
  
  var body: some View {
    VStack(alignment: .leading) {
      Text(workoutTemplate.wrappedName)
        .font(.headline)
      if let unwrappedWorkout = workout {
        Text(getWorkoutDate(workout: unwrappedWorkout))
          .font(.subheadline)
          .foregroundColor(.gray)
      } else {
        Text("Last Workout: Never")
          .font(.subheadline)
          .foregroundColor(.gray)
      }
      
    }.accentColor(Color(.label))
    
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
    HStack {
      RowImage(iconName: workoutTemplate.wrappedIconName)
      
      WorkoutRowLabel(workoutTemplate: workoutTemplate)
        .padding(.leading, CGFloat(10))
    }
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
        .environmentObject(WorkoutStore(managedObjectContext: PersistenceController.shared.container.viewContext))
    }
    
    
  }
}
#endif
