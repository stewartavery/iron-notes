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
import Snap

struct TopToolbarContent: View {
  @Binding var workoutSheet: WorkoutSheet?
  @EnvironmentObject var keyboardMonitor: KeyboardMonitor
  
  var body: some View {
    switch(keyboardMonitor.keyboardStatus) {
    case .hidden:
      Menu {
        Button {
          workoutSheet = .workout
        } label: {
          Label("Change Workout", systemImage: "note.text")
        }
        Button {
          workoutSheet = .exercises
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
  
  @ObservedObject var stopwatchManager: StopwatchManager
  @ObservedObject var keyboardMonitor: KeyboardMonitor
  @ObservedObject var workoutTemplate: WorkoutTemplate
  
  @StateObject private var workout: Workout
  
  @State private var workoutSheet: WorkoutSheet? = nil
  @State private var isEditing = false
  @State private var isModifyingSet: Bool = false
  @State private var bottomPadding: CGFloat = MIN_CARD_HEIGHT
  @State private var scrollDirection: ScrollDirection = .none
  
  init(stopwatchManager: StopwatchManager, keyboardMonitor: KeyboardMonitor, workoutTemplate: WorkoutTemplate) {
    self.stopwatchManager = stopwatchManager
    self.keyboardMonitor = keyboardMonitor
    self.workoutTemplate = workoutTemplate
    _workout = StateObject(wrappedValue: Workout.getNewWorkoutFromTemplate(workoutTemplate: workoutTemplate))
  }
  
  var body: some View {
    ZStack {
      NavigationView {
        List {
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
              presentationMode.wrappedValue.dismiss()
            }
          }
          ToolbarItem(placement: .primaryAction) {
            TopToolbarContent(workoutSheet: $workoutSheet)
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
        .gesture(
          DragGesture().onChanged { value in
            if value.translation.height > 0 {
              scrollDirection = .up(value.translation.height)
            } else {
              scrollDirection = .down(value.translation.height)
            }
          }
        )
      }
      DelayedSlideOverCard(
        stopwatchManager: stopwatchManager,
        keyboardMonitor: keyboardMonitor,
        scrollDirection: $scrollDirection
      ).environmentObject(workout)
    }
    
  }
  
  private func getBottomPadding(_ keyboardStatus: KeyboardStatus) -> CGFloat {
    switch keyboardStatus {
    case .hidden:
      return MIN_CARD_HEIGHT
    case .presented(_):
      print("Presented")
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
    ActiveWorkout(stopwatchManager: StopwatchManager(), keyboardMonitor: KeyboardMonitor(), workoutTemplate: IronNotesModelFactory.getWorkoutTemplate())
      .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
      .environmentObject(IronNotesModelFactory.getWorkout())
      .environmentObject(StopwatchManager())
  }
}
#endif
