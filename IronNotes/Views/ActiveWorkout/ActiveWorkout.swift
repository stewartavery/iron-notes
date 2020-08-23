//
//  ActiveWorkout.swift
//  IronNotes
//
//  Created by Stewart Avery on 2/16/20.
//  Copyright © 2020 Stewart Avery. All rights reserved.
//

import SwiftUI
import CoreData
import Combine

struct TopToolbarContent: View {
  @Binding var isEditing: Bool
  @EnvironmentObject var keyboardMonitor: KeyboardMonitor
  
  var body: some View {
    switch(keyboardMonitor.keyboardStatus) {
    case .hidden:
      Menu {
        Button {
          print("yo")
        } label: {
          Label("Change Workout", systemImage: "note.text")
        }
        Button {
          isEditing = true
        } label: {
          Label("Edit Exercises", systemImage: "pencil")
        }
        Button {
          print("remove")
        } label: {
          Label("Remove Workout", systemImage: "trash")
        }.foregroundColor(Color.red)
      } label: {
        Image(systemName: "ellipsis.circle")
      }
    case .presented(_):
      Button {
        self.hideKeyboard()
      } label: {
        Image(systemName: "keyboard.chevron.compact.down")
      }
    }
  }
}

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

struct ActiveWorkout: View {
  @EnvironmentObject var workout: Workout
  @Environment(\.managedObjectContext) var moc
  @EnvironmentObject var stopwatchManager: StopwatchManager
  @EnvironmentObject var keyboardMonitor: KeyboardMonitor
  
  
  @State var isEditing = false
  @State var isModifyingSet: Bool = false
  
  var body: some View {
    ZStack {
      List {
        StartButton()
        ForEach(workout.routinesArray, id: \.self) { exercise in
          Section {
            ExerciseCard(exercise: exercise)
          }
        }
      }
      .navigationBarTitle(Text(workout.meta.name))
      .toolbar {
        ToolbarItem(placement: .primaryAction) {
          TopToolbarContent(isEditing: $isEditing)
        }
      }
      .buttonStyle(BorderlessButtonStyle())
      .sheet(
        isPresented: self.$isEditing,
        content: {
          ExerciseEditor(
            workout: workout,
            isPresented: self.$isEditing
          ).environment(\.managedObjectContext, moc)
        })
      .listStyle(InsetGroupedListStyle())
      
      switch stopwatchManager.mode {
      case .running, .paused:
        DelayedSlideOverCard()
      case .stopped:
        EmptyView()
      }
    }
  }
}


extension View {
  func hideKeyboard() {
    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
  }
}

#if DEBUG
struct ActiveWorkout_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      ActiveWorkout()
    }
    .navigationViewStyle(StackNavigationViewStyle())
    .environmentObject(IronNotesModelFactory.getWorkout())
    .environmentObject(StopwatchManager())
  }
}
#endif
