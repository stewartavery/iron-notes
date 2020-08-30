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
  @Binding var workoutSheet: WorkoutSheet
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

enum WorkoutSheet {
  case workout
  case exercises
  case none
  
  var isPresented: Bool {
    switch self {
    case .none:
      return false
    default:
      return true
    }
  }
}

struct ActiveWorkout: View {
  @EnvironmentObject var workout: Workout
  @Environment(\.managedObjectContext) var moc
  @Environment(\.presentationMode) var presentationMode
  @ObservedObject var stopwatchManager: StopwatchManager
  @ObservedObject var keyboardMonitor: KeyboardMonitor
  
  @State var workoutSheet: WorkoutSheet = .none
  @State var isEditing = false
  @State var isModifyingSet: Bool = false
  @State var bottomPadding: CGFloat = 0
  
  var body: some View {
    let isSheetPresented = Binding<Bool>(get: {
      workoutSheet.isPresented
    }, set: { b in
      workoutSheet = .none
    })
    
    return ZStack {
      NavigationView {
        List {
          ForEach(workout.routinesArray, id: \.self) { exercise in
            Section {
              ExerciseCard(exercise: exercise)
            }
          }
          .padding(.bottom, bottomPadding)
        }
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
        .sheet(
          isPresented: isSheetPresented,
          content: {
            switch workoutSheet {
            case .exercises:
              ExerciseEditor(workout: workout)
                .environment(\.managedObjectContext, moc)
            case .workout:
              WorkoutMetaEditor(workout: workout)
                .environment(\.managedObjectContext, moc)
            default:
              EmptyView()
            }
          })
        .listStyle(InsetGroupedListStyle())
      }
      
      DelayedSlideOverCard(stopwatchManager: stopwatchManager, keyboardMonitor: keyboardMonitor)
    }
    .onChange(of: keyboardMonitor, perform: { _ in
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
        bottomPadding = getBottomPadding(keyboardMonitor.keyboardStatus)
      }
    })
  }
  
  func getBottomPadding(_ keyboardStatus: KeyboardStatus) -> CGFloat {
    switch keyboardStatus {
    case .hidden:
      return 200
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
    ActiveWorkout(stopwatchManager: StopwatchManager(), keyboardMonitor: KeyboardMonitor())
      .environmentObject(IronNotesModelFactory.getWorkout())
      .environmentObject(StopwatchManager())
  }
}
#endif
