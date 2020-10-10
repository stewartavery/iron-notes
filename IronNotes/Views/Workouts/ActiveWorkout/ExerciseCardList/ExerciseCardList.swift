//
//  ExerciseCardList.swift
//  IronNotes
//
//  Created by Stewart Avery on 9/17/20.
//  Copyright © 2020 Stewart Avery. All rights reserved.
//

import SwiftUI

struct WorkoutToolbar: View {
  @Environment(\.scenePhase) private var scenePhase
  
  @Environment(\.presentationMode) var presentationMode
  
  @StateObject var stopwatchManager = StopwatchManager()
  
  @EnvironmentObject var keyboardMonitor: KeyboardMonitor
  @EnvironmentObject var workout: Workout
  @EnvironmentObject var workoutStore: WorkoutStore
  
  @Binding var workoutSheet: WorkoutSheet?
  
  var body: some View {
    Group {
    ToolbarItem(placement: .cancellationAction) {
      Button("Dismiss") {
        presentationMode.wrappedValue.dismiss()
      }
    }

    ToolbarItem(placement: .primaryAction) {
      TopToolbarContent(workoutSheet: $workoutSheet)
        .environmentObject(keyboardMonitor)
    }

    ToolbarItem(placement: .bottomBar) {
      Text("hey bitch")
    }

    ToolbarItem(placement: .bottomBar) {
      WorkoutToolbarItem()
        .environmentObject(workout)
        .environmentObject(workoutStore)
        .environmentObject(stopwatchManager)
        .onAppear {
          resumeTimer()
        }
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
    }
  }
  
  private func resumeTimer() {
    if let startTime = workout.startTime {
      stopwatchManager.resumeFromBackground(startTime: startTime)
    }
  }
}

struct WorkoutToolbarItem: View {
  @EnvironmentObject var stopwatchManager: StopwatchManager
  @EnvironmentObject var workout: Workout
  @EnvironmentObject var workoutStore: WorkoutStore
  
  var body: some View {
    Group {
      switch stopwatchManager.mode {
      case .running:
        HStack {
          StatusContent()
          Spacer()
          BottomBarContent()
        }
      case .stopped:
        StartButton()
      }
    }
  }
}

struct ExerciseCardList: View {
  @Environment(\.managedObjectContext) var moc
  @Environment(\.presentationMode) var presentationMode
  
  @EnvironmentObject var keyboardMonitor: KeyboardMonitor
  @EnvironmentObject var workout: Workout
  @EnvironmentObject var workoutStore: WorkoutStore
  
  @Binding var workoutSheet: WorkoutSheet?
  
  @State private var bottomPadding: CGFloat = minCardHeight
  
  var body: some View {
    NavigationView {
      List {
        ForEach(workout.routinesArray) { exercise in
          Section {
            ExerciseCard(exercise: exercise, isActive: true)
          }
        }
      }
      .navigationBarTitle(Text("Workout Log"), displayMode: .inline)
      .toolbar {
        WorkoutToolbar(workoutSheet: $workoutSheet)
          .environmentObject(keyboardMonitor)
          .environmentObject(workout)
          .environmentObject(workoutStore)
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
}
struct ExerciseCardList_Previews: PreviewProvider {
  @State static var workoutSheet: WorkoutSheet? = nil
  
  static var previews: some View {
    Group {
      ExerciseCardList(workoutSheet: $workoutSheet)
        .previewDevice("iPhone 11 Pro Max")
      
      ExerciseCardList(workoutSheet: $workoutSheet)
        .previewDevice("iPhone SE")
        .environment(\.sizeCategory, .extraExtraLarge)
        .environment(\.colorScheme, .dark)
      
      
    }
    .environmentObject(KeyboardMonitor())
    .environmentObject(IronNotesModelFactory.getWorkout())
  }
}
