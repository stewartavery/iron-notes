//
//  StartButton.swift
//  IronNotes
//
//  Created by Stewart Avery on 8/29/20.
//  Copyright © 2020 Stewart Avery. All rights reserved.
//

import SwiftUI

struct BottomBarContent: View {
  @ObservedObject var stopwatchManager: StopwatchManager
  @ObservedObject var workout: Workout
  @Environment(\.presentationMode) var presentationMode
  
  var body: some View {
    switch stopwatchManager.mode {
    case .running:
      Button {
        workout.duration = Int16(stopwatchManager.secondsElapsed)
        stopwatchManager.stop()
        presentationMode.wrappedValue.dismiss()
      } label: {
        Image(systemName: "stop.fill")
      }
    case .stopped:
      Text("")
    }
  }
}

struct StatusContent: View {
  @ObservedObject var stopwatchManager: StopwatchManager
  
  var body: some View {
    switch stopwatchManager.mode {
    case .running:
      Text((stopwatchManager.secondsElapsed.asString(style: .positional)))
        .fontWeight(.bold)
        .font(.title)
    case .stopped:
      Text("")
    }
  }
}


struct StartButton: View {
  @EnvironmentObject var stopwatchManager: StopwatchManager
  @EnvironmentObject var workout: Workout
  
  var body: some View {
    HStack {
      Label {
        Text("Start")
          .fontWeight(.bold)
      } icon: {
        Image(systemName: "play.fill")
      }
    }
    .frame(maxWidth: .infinity)
    .padding()
    .background(Color.orange)
    .font(.headline)
    .cornerRadius(7)
    .foregroundColor(Color.white)
    .onTapGesture {
      workout.startTime = Date()
      stopwatchManager.start(workout)
    }
  }
}


#if DEBUG
struct StartButton_Previews: PreviewProvider {
  static var previews: some View {
    StartButton()
      .environmentObject(StopwatchManager())
  }
}
#endif
