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

struct ActiveWorkout: View {
  @EnvironmentObject var workout: Workout
  @EnvironmentObject var stopwatchManager: StopwatchManager
  @EnvironmentObject var keyboardMonitor: KeyboardMonitor
  
  @Environment(\.managedObjectContext) var moc
  @State var isEditing = false
  @State var isModifyingSet: Bool = false
  
  var body: some View {
    List {
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
      
      ForEach(workout.routinesArray.sorted(by: {$0.position < $1.position}), id: \.self) { exercise in
        Section {
          ExerciseCard(exercise: exercise)
        }
      }
    }
    .navigationBarTitle(Text(workout.meta.name))
    .toolbar {
      ToolbarItem(placement: .primaryAction) {
        switch(keyboardMonitor.keyboardStatus) {
        case .hidden:
          Button {
            isEditing.toggle()
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
      ToolbarItem(placement: .bottomBar) {
        switch stopwatchManager.mode {
        case .running, .paused:
          Button {
            stopwatchManager.stop()
          } label: {
            Image(systemName: "stop.fill")
          }
        case .stopped:
          Text("")
        }      }
    
      ToolbarItem(placement: .status) {
        switch stopwatchManager.mode {
        case .running, .paused:
          Text((stopwatchManager.secondsElapsed.asString(style: .positional)))
        case .stopped:
          Text("")
        }
      }
    }
    .buttonStyle(BorderlessButtonStyle())
    .sheet(
      isPresented: self.$isEditing,
      content: {
        ExerciseEditor(
          workout: workout,
          isPresented: self.$isEditing
        )
      })
    .listStyle(InsetGroupedListStyle())
  }
  
  func createNewSet(exercise: Exercise) {
    let newSet = ExerciseSet(context: moc)
    newSet.setPosition = Int16(exercise.exerciseSetArray.count + 1)
    exercise.addToSets(newSet)
    
    do {
      try self.moc.save()
      print("Set added.")
    } catch {
      print(error.localizedDescription)
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
