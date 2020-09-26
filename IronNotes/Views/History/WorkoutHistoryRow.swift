//
//  WorkoutHistoryRow.swift
//  IronNotes
//
//  Created by Stewart Avery on 9/25/20.
//  Copyright © 2020 Stewart Avery. All rights reserved.
//

import SwiftUI

struct WorkoutHistoryRow: View {
  var workout: Workout
  
  var body: some View {
    HStack {
      VStack(alignment: .leading) {
        Text(workout.meta.name).font(.headline)
        Text(workout.readableDate)
      }
      
      Spacer()
      
      Image(systemName: "chevron.forward")
        .resizable()
        .scaledToFit()
        .frame(width: 12, height: 12)
        .foregroundColor(Color.gray)

      
    }
  }
}

struct WorkoutHistoryRow_Previews: PreviewProvider {
  static var previews: some View {
    WorkoutHistoryRow(workout: IronNotesModelFactory.getWorkout())
  }
}
