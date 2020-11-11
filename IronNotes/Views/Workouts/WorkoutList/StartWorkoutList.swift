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
      switch (workoutInput, workoutStore.workoutStatus, workoutStore.primaryWorkout) {
      case (.template(let template), .stopped, .none):
        workoutStore.setupPrimaryWorkout(with: template)
      case (.noTemplate, .stopped, .none):
        workoutStore.setupPrimaryWorkout()
      default:
        break
      }
    }
  }
  
  var nonActiveWorkouts: [WorkoutTemplate] {
    switch (workoutStore.workoutStatus, workoutStore.primaryWorkout)  {
    case (.running, .some(let workout)):
      guard let meta = workout.meta else {
        return workoutTemplateStore.items
      }
      
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
          switch (workoutStore.workoutStatus, workoutStore.primaryWorkout) {
          case (.running, .some(let workout)):
            if let meta = workout.meta {
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
        switch workoutStore.primaryWorkout {
        case .some(let workout):
          ActiveWorkout(
            keyboardMonitor: keyboardMonitor,
            workout: workout,
            workoutStore: workoutStore
          ).environment(\.scenePhase, scenePhase)
        default:
          EmptyView()
        }
        
      }
      .navigationBarTitle("Workouts")
    }
  }
  
  private func dismissModal() -> Void {
    switch (workoutStore.workoutStatus, workoutStore.primaryWorkout)  {
    case (.stopped, .some(let workout)) where workout.duration > 0:
      workoutStore.finishPrimaryWorkout()
    case (.stopped, .some(let workout)):
      workout.deleteWorkout()
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
