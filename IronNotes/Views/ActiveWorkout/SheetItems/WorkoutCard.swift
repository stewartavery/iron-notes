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
  
  @EnvironmentObject var cardDetails: CardDetails
  @EnvironmentObject var workout: Workout
  
  var body: some View {
    VStack(alignment: .leading) {
      switch stopwatchManager.mode {
      case .running, .paused:
        HStack {
          StatusContent(stopwatchManager: stopwatchManager)
          Spacer()
          BottomBarContent(stopwatchManager: stopwatchManager)
        }
      case .stopped:
        StartButton()
      }
      
      switch cardDetails.position {
      case .middle, .top:
        VStack(alignment: .leading) {
          WorkoutRowLabel(workoutTemplate: workout.meta)
          
          Divider()
          
          if workout.isNotePresent {
            Text(workout.wrappedNote)
              .font(.body)
              .padding(.top)
          }
            
          Spacer()
      }.padding(.top)

      case .bottom:
        Spacer()
      }
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
