//
//  WorkoutRow.swift
//  IronNotes
//
//  Created by Stewart Avery on 7/21/19.
//  Copyright © 2019 Stewart Avery. All rights reserved.
//

import SwiftUI

struct WorkoutRow: View {
  var workout: Workout
  
  var body: some View {
    HStack {
      RowImage(iconName: self.workout.iconName ?? "test")
      
      VStack(alignment: .leading) {
        Text(self.workout.name)
          .font(.headline)
        Text(self.workout.description)
          .font(.subheadline)
        Text("Last Workout: " + self.workout.dayDifference(from: self.workout.lastWorkoutDate ?? Date()))
          .font(.subheadline)
          .foregroundColor(.gray)
      }.padding(.leading, CGFloat(10))
    }
    .frame(height: 100)
  }
}

#if DEBUG
struct WorkoutRow_Previews: PreviewProvider {
  static var previews: some View {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    return ContentView().environment(\.managedObjectContext, context)
  }
}
#endif
