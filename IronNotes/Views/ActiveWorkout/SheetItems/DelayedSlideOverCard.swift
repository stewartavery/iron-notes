//
//  DelayedSlideOverCard.swift
//  IronNotes
//
//  Created by Stewart Avery on 8/23/20.
//  Copyright © 2020 Stewart Avery. All rights reserved.
//

import SwiftUI

struct BottomBarContent: View {
  @EnvironmentObject var stopwatchManager: StopwatchManager
  
  var body: some View {
    switch stopwatchManager.mode {
    case .running, .paused:
      Button {
        stopwatchManager.stop()
      } label: {
        Image(systemName: "stop.fill")
      }
    case .stopped:
      Text("")
    }
  }
}

struct StatusContent: View {
  @EnvironmentObject var stopwatchManager: StopwatchManager
  
  var body: some View {
    switch stopwatchManager.mode {
    case .running, .paused:
      Text((stopwatchManager.secondsElapsed.asString(style: .positional)))
    case .stopped:
      Text("")
    }
  }
}

struct StartButton: View {
  @EnvironmentObject var stopwatchManager: StopwatchManager
  
  var body: some View {
    Button {
      stopwatchManager.start()
    } label: {
      Label {
        HStack {
          Text("Start")
          Spacer()
        }
      } icon: {
        Image(systemName: "play.fill")
      }
      .foregroundColor(Color.orange)
      .font(.headline)
    }
  }
}

struct DelayedSlideOverCard: View {
  @EnvironmentObject var keyboardMonitor: KeyboardMonitor
  @State var isViewHidden = true
  @State var delay = 0.0
  
  var body: some View {
    Group {
      switch (keyboardMonitor.keyboardStatus, isViewHidden)  {
      case (.hidden, true):
        Text("").onAppear {
          DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            self.isViewHidden = false
            self.delay = 0.0
          }
        }
      case (.hidden, false):
        SlideOverCard {
          VStack {
            HStack {
              StatusContent()
              Spacer()
              BottomBarContent()
            }
            .padding()
            
            Divider()
            Spacer()
          }
        }
        .transition(.move(edge: .bottom))
        .animation(/*@START_MENU_TOKEN@*/.easeIn/*@END_MENU_TOKEN@*/)
      case (.presented(_), _):
        Text("").onAppear {
          self.isViewHidden = true
          self.delay = 0.3
        }
      }
    }
  }
}
