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
  @Environment(\.scenePhase) private var scenePhase
  
  @StateObject var stopwatchManager = StopwatchManager()
  
  @ObservedObject var keyboardMonitor: KeyboardMonitor
  @ObservedObject var workout: Workout
  @ObservedObject var workoutStore: WorkoutStore
  
  @State private var workoutSheet: WorkoutSheet? = nil
  
  var body: some View {
    ZStack {
      ExerciseCardList(
        keyboardMonitor: keyboardMonitor,
        workout: workout,
        workoutSheet: $workoutSheet
      )
      
      DelayedSlideOverCard(workoutSheet: $workoutSheet)
      .environmentObject(stopwatchManager)
      .environmentObject(keyboardMonitor)
      .environmentObject(workoutStore)
    }
    .onAppear {
      resumeTimer()
    }
    .environmentObject(workout)
    .onChange(of: scenePhase) { phase in
      switch phase {
      case .active:
        resumeTimer()
        break
      default:
        break
      }
    }
  }
  
  func resumeTimer() {
    if let startTime = workout.startTime {
      stopwatchManager.resumeFromBackground(startTime: startTime)
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
  @State static var workoutStatus: WorkoutStatus = .stopped
  static var previews: some View {
    ActiveWorkout(
      keyboardMonitor: KeyboardMonitor(),
      workout: IronNotesModelFactory.getWorkout(),
      workoutStore: WorkoutStore(managedObjectContext: PersistenceController.shared.container.viewContext)
    )
    .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
    .environmentObject(IronNotesModelFactory.getWorkout())
  }
}
#endif

struct ExerciseCardList: View {
  @Environment(\.managedObjectContext) var moc
  @Environment(\.presentationMode) var presentationMode
  @EnvironmentObject var stopwatchManager: StopwatchManager
  
  @ObservedObject var keyboardMonitor: KeyboardMonitor
  @ObservedObject var workout: Workout
  
  @Binding var workoutSheet: WorkoutSheet?
  
  @State private var bottomPadding: CGFloat = minCardHeight
  
  var body: some View {
    NavigationView {
      List {
        //        if workout.routinesArray.count == 0 {
        //          VStack {
        //            Text("There's nothing here.")
        //            Button("Add some workouts") {
        //              print("HEY")
        //            }
        //            Text("to get started.")
        //          }
        //        }
        ForEach(workout.routinesArray) { exercise in
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
            presentationMode.wrappedValue.dismiss()
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
