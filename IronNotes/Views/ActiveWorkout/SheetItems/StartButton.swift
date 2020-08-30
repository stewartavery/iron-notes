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
  @Environment(\.presentationMode) var presentationMode
  
  var body: some View {
    switch stopwatchManager.mode {
    case .running, .paused:
      Button {
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
    case .running, .paused:
      Text((stopwatchManager.secondsElapsed.asString(style: .positional)))
        .fontWeight(.bold)
        .font(.title)
    case .stopped:
      Text("")
    }
  }
}


struct StartButton: View {
  @ObservedObject var stopwatchManager: StopwatchManager
  
  var body: some View {
    Button {
      stopwatchManager.start()
    } label: {
      HStack {
        Spacer()
        Label {
          Text("Start")
            .fontWeight(.bold)
        } icon: {
          Image(systemName: "play.fill")
        }
        Spacer()
      }
    }
    .padding()
    .background(Color.orange)
    .font(.headline)
    .cornerRadius(7)
    .accentColor(.white)
  }
}


#if DEBUG
struct StartButton_Previews: PreviewProvider {
  static var previews: some View {
    StartButton(stopwatchManager: StopwatchManager())
      .environmentObject(StopwatchManager())
  }
}
#endif
