//
//  WorkoutHistoryRow.swift
//  IronNotes
//
//  Created by Stewart Avery on 9/25/20.
//  Copyright © 2020 Stewart Avery. All rights reserved.
//

import SwiftUI

struct WorkoutHistoryRow: View {
  @Environment(\.colorScheme) var colorScheme: ColorScheme
  var workout: Workout
  
  var workoutMetaName: String {
    return workout.meta?.wrappedName ?? ""
  }
  
  var body: some View {
    HStack {
      VStack(alignment: .leading) {
        Text(workoutMetaName)
          .font(.headline)
        Text(workout.readableDate)
          .font(.body)
          .foregroundColor(Color.gray)
      }
      
      Spacer()
      
      Image(systemName: "chevron.forward")
        .resizable()
        .scaledToFit()
        .frame(width: 12, height: 12)
        .foregroundColor(Color.gray)
    }
    .padding()
    .background(
      RoundedRectangle(cornerRadius: 10)
        .fill(colorScheme == .light ? Color.white : Color(UIColor.systemGray6))
    )
  }
}

struct WorkoutHistoryRow_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      ZStack {
        Color(UIColor.systemGray6)
        WorkoutHistoryRow(workout: IronNotesModelFactory.getWorkout())
          .padding()
      }
      ZStack {
        Color.black
        WorkoutHistoryRow(workout: IronNotesModelFactory.getWorkout())
          .padding()
          .environment(\.colorScheme, .dark)
        
      }
    }
  }
}
