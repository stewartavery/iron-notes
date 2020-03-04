//
//  WorkoutRow.swift
//  IronNotes
//
//  Created by Stewart Avery on 7/21/19.
//  Copyright © 2019 Stewart Avery. All rights reserved.
//

import SwiftUI
import CoreData

struct WorkoutRow: View {
  var workout: Workout
  
  var body: some View {
    HStack {
      RowImage(iconName: self.workout.wrappedIconName)
      
      VStack(alignment: .leading) {
        Text(verbatim: self.workout.wrappedName)
          .font(.headline)
        Text(verbatim: self.workout.wrappedDesc)
          .font(.subheadline)
        Text(verbatim: self.getWorkoutDate())
          .font(.subheadline)
          .foregroundColor(.gray)
      }.padding(.leading, CGFloat(10))
    }
    .frame(height: 100)
  }
  
  func getWorkoutDate() -> String {
    return "Last Workout: " +
      self.workout.dayDifference(
        from: self.workout.wrappedLastWorkoutDate
    )
  }
}

#if DEBUG
struct WorkoutRow_Previews: PreviewProvider {
  static var previews: some View {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let workout = Workout(context: context)
    workout.name = "Test"
    workout.iconName = "barbell"
    workout.desc = "Test Description"
    workout.lastWorkoutDate = Date()
    workout.routines = []
    
    return WorkoutRow(workout: workout)
  }
}
#endif
