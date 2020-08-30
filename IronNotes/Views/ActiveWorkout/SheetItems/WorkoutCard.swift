//
//  WorkoutCard.swift
//  IronNotes
//
//  Created by Stewart Avery on 8/29/20.
//  Copyright © 2020 Stewart Avery. All rights reserved.
//

import SwiftUI

struct WorkoutCard: View {
  @ObservedObject var stopwatchManager: StopwatchManager
  @EnvironmentObject var workout: Workout
  
  var body: some View {
    var isNotePresent: Bool {
      return workout.wrappedNote.count > 0
    }
    
    // TODO: try making this an ObservedObject instead to see if it fixes bug
    return VStack(alignment: .leading) {
      WorkoutRowLabel(workout: workout)

      switch stopwatchManager.mode {
      case .running, .paused:
        HStack {
          StatusContent(stopwatchManager: stopwatchManager)
          Spacer()
          BottomBarContent(stopwatchManager: stopwatchManager)
        }
        .padding()
      case .stopped:
          StartButton(stopwatchManager: stopwatchManager)
      }
            
      Divider()
      
      if isNotePresent {
        Text(workout.wrappedNote)
          .font(.body)
          .padding(.top)
      }
      Spacer()
       
    }
    .padding(.leading)
    .padding(.trailing)
  }
}

#if DEBUG
struct WorkoutCard_Previews: PreviewProvider {
  static var previews: some View {
    WorkoutCard(stopwatchManager: StopwatchManager())
      .environmentObject(IronNotesModelFactory.getWorkout())
  }
}
#endif
