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



enum WorkoutSheet: String, Identifiable {
  var id: String {
    return rawValue
  }
  
  case workout, exercises
}

enum ScrollDirection: Equatable {
  case none
  case up(CGFloat)
  case down(CGFloat)
}

struct ActiveWorkout: View {
  @Environment(\.managedObjectContext) var moc
  @Environment(\.presentationMode) var presentationMode
  
  @ObservedObject private var stopwatchManager: StopwatchManager
  @ObservedObject private var keyboardMonitor: KeyboardMonitor
  @ObservedObject private var workoutTemplate: WorkoutTemplate
  
  @StateObject private var workout: Workout
  
  @State private var workoutSheet: WorkoutSheet? = nil
  @State private var bottomPadding: CGFloat = minCardHeight
  
  init(
    stopwatchManager: StopwatchManager,
    keyboardMonitor: KeyboardMonitor,
    workoutTemplate: WorkoutTemplate)
  {
    self.stopwatchManager = stopwatchManager
    self.keyboardMonitor = keyboardMonitor
    self.workoutTemplate = workoutTemplate
    
    _workout = {
      switch stopwatchManager.mode {
      case .stopped:
        return StateObject(wrappedValue: Workout.getNewWorkoutFromTemplate(workoutTemplate: workoutTemplate))
      case .running(let workout):
        return StateObject(wrappedValue: workout)
      }
    }()
    
  }
  
  var body: some View {
    ZStack {
      NavigationView {
        List {
          if workout.routinesArray.count == 0 {
            VStack {
              Text("There's nothing here.")
              Button("Add some workouts") {
                print("HEY")
              }
              Text("to get started.")
            }
          }
          ForEach(workout.routinesArray, id: \.self) { exercise in
            Section {
              ExerciseCard(exercise: exercise)
            }
          }
        }
        .onChange(of: keyboardMonitor.keyboardStatus, perform: { _ in
          DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            bottomPadding = getBottomPadding(keyboardMonitor.keyboardStatus)
          }
        })
        .padding(.bottom, bottomPadding)
        .navigationBarTitle(Text("Workout Log"), displayMode: .inline)
        .toolbar {
          ToolbarItem(placement: .cancellationAction) {
            Button("Dismiss") {
              dismissModal()
            }
          }
          ToolbarItem(placement: .primaryAction) {
            TopToolbarContent(workoutSheet: $workoutSheet)
              .environmentObject(keyboardMonitor)
          }
        }
        .buttonStyle(BorderlessButtonStyle())
        .sheet(item: $workoutSheet) { workoutSheet in
          switch workoutSheet {
          case .exercises:
            ExerciseEditor(workout: workout)
              .environment(\.managedObjectContext, moc)
          case .workout:
            WorkoutMetaEditor(workout: workout)
              .environment(\.managedObjectContext, moc)
          }
        }
        .listStyle(InsetGroupedListStyle())
      }
      
      DelayedSlideOverCard(
        stopwatchManager: stopwatchManager,
        keyboardMonitor: keyboardMonitor,
        workoutSheet: $workoutSheet
      ).environmentObject(workout)
    }
    
  }
  
  private func dismissModal() -> Void {
    presentationMode.wrappedValue.dismiss()
    
    switch stopwatchManager.mode {
    case .stopped:
      // to prevent momentary flash while dismissing
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
        workout.deleteWorkout()
      }
    default:
      break
    }
  }
  
  private func getBottomPadding(_ keyboardStatus: KeyboardStatus) -> CGFloat {
    switch keyboardStatus {
    case .hidden:
      return minCardHeight
    case .presented(_):
      return 0
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
    ActiveWorkout(
      stopwatchManager: StopwatchManager(),
      keyboardMonitor: KeyboardMonitor(),
      workoutTemplate: IronNotesModelFactory.getWorkoutTemplate()
    )
    .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
    .environmentObject(IronNotesModelFactory.getWorkout())
  }
}
#endif
