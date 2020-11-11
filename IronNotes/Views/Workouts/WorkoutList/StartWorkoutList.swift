//
//  StartWorkoutList.swift
//  IronNotes
//
//  Created by Stewart Avery on 7/3/19.
//  Copyright © 2019 Stewart Avery. All rights reserved.
//

import SwiftUI

enum WorkoutInput: Identifiable {
  case template(WorkoutTemplate)
  case noTemplate
  
  var id: String {
    switch self {
    case .template(_):
      return "template"
    case .noTemplate:
      return "noTemplate"
    }
  }
}

struct StartWorkoutList : View {
  @Environment(\.managedObjectContext) var moc
  @Environment(\.scenePhase) private var scenePhase
  
  @EnvironmentObject var workoutStore: WorkoutStore
  @EnvironmentObject var workoutTemplateStore: WorkoutTemplateStore
  @EnvironmentObject var keyboardMonitor: KeyboardMonitor
  
  @State var isCreateViewVisible = false
  @State var workoutInput: WorkoutInput? = nil {
    didSet {
      switch (workoutInput, workoutStore.activeWorkout) {
      case (.template(let template), .none):
        workoutStore.setupPrimaryWorkout(with: template)
      case (.noTemplate, .none):
        workoutStore.setupPrimaryWorkout()
      default:
        break
      }
    }
  }
  
  var nonActiveWorkouts: [WorkoutTemplate] {
    guard let activeWorkout = workoutStore.activeWorkout else {
      return workoutTemplateStore.items
    }
    
    switch activeWorkout.workout.meta  {
    case .some(let meta) where activeWorkout.status == .running:
      return workoutTemplateStore.items.filter {
        meta !== $0
      }
    default:
      return workoutTemplateStore.items
    }
  }
  
  var activeWorkoutHeader: some View {
    Text("Active Workout")
      .font(.headline)
      .textCase(nil)
  }
  
  var body: some View {
    NavigationView {
      List {
        Group {
          switch (workoutStore.activeWorkout) {
          case (.some(let activeWorkout)) where activeWorkout.status == .running:
            if let meta = activeWorkout.workout.meta {
              Section(header: activeWorkoutHeader) {
                Button {
                  workoutInput = .template(meta)
                } label: {
                  WorkoutRow(workoutTemplate: meta)
                }
              }
            }
          default:
            EmptyView()
          }
        }
        Section {
          ForEach(nonActiveWorkouts) { workoutTemplate in
            Button {
              workoutInput = .template(workoutTemplate)
            } label: {
              WorkoutRow(workoutTemplate: workoutTemplate)
            }
          }
          Button {
            workoutInput = .noTemplate
          } label: {
            AddWorkoutRow()
          }
        }
        
      }
      .listStyle(InsetGroupedListStyle())
      .fullScreenCover(
        item: $workoutInput,
        onDismiss: dismissModal) { _ in
        switch workoutStore.activeWorkout {
        case .some(let activeWorkout):
          ActiveWorkoutEditor(
            keyboardMonitor: keyboardMonitor,
            activeWorkout: activeWorkout
          ).environment(\.scenePhase, scenePhase)
        case .none:
          EmptyView()
        }
        
      }
      .navigationBarTitle("Workouts")
    }
  }
  
  private func dismissModal() -> Void {
    guard let activeWorkout = workoutStore.activeWorkout else { return }
    
    switch (activeWorkout.status)  {
    case .finished where activeWorkout.workout.duration > 0:
      workoutStore.finishPrimaryWorkout()
    case .finished:
      activeWorkout.workout.deleteWorkout()
      workoutStore.finishPrimaryWorkout()
    default:
      // a workout is currently going on
      break
    }
  }
}

#if DEBUG
struct StartWorkoutList_Preview : PreviewProvider {
  static var previews: some View {
    StartWorkoutList()
      .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
      .environmentObject(KeyboardMonitor())
      .environmentObject(StopwatchManager())
      .environmentObject(WorkoutTemplateStore(managedObjectContext: PersistenceController.shared.container.viewContext))
      .environmentObject(WorkoutStore(managedObjectContext: PersistenceController.shared.container.viewContext))
  }
}
#endif
