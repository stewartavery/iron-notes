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
  @Environment(\.presentationMode) var presentationMode
  
  var body: some View {
    switch stopwatchManager.mode {
    case .running, .paused:
      Button {
        stopwatchManager.stop()
//        presentationMode.wrappedValue.dismiss()
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
        .fontWeight(.bold)
        .font(.title)
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
    StartButton().environmentObject(StopwatchManager())
  }
}
#endif


struct WorkoutCard: View {
  @EnvironmentObject var stopWatchManager: StopwatchManager
  @EnvironmentObject var workout: Workout
  
  var body: some View {
    var isNotePresent: Bool {
      return workout.wrappedNote.count > 0
    }
    
    // TODO: try making this an ObservedObject instead to see if it fixes bug
    return VStack(alignment: .leading) {
      switch stopWatchManager.mode {
      case .running, .paused:
        HStack {
          StatusContent()
          Spacer()
          BottomBarContent()
        }
        .padding()
      case .stopped:
          StartButton()
      }
      
      WorkoutRowLabel(workout: workout)
      
      Divider()
      
      if isNotePresent {
        Text(workout.wrappedNote)
          .font(.body)
          .padding(.top)
      }
      Spacer()
       
    } .padding(.leading)
    .padding(.trailing)
    
  }
}

#if DEBUG
struct WorkoutCard_Previews: PreviewProvider {
  static var previews: some View {
    WorkoutCard()
      .environmentObject(StopwatchManager())
      .environmentObject(IronNotesModelFactory.getWorkout())
  }
}
#endif


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
          WorkoutCard()
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
