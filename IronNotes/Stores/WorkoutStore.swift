//
//  WorkoutStore.swift
//  IronNotes
//
//  Created by Stewart Avery on 9/8/20.
//  Copyright © 2020 Stewart Avery. All rights reserved.
//

import CoreData
import Combine

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

class WorkoutStore: NSObject, ObservableObject {
  @Published private(set) var workouts: [Workout] = [] {
    didSet {
      self.groupedItems = Dictionary.init(grouping: workouts) {
        let comps = Calendar.current.dateComponents([.month, .year], from: $0.wrappedStartTime)
        return String(format: "%ld-%.2ld", comps.year!, comps.month!)
      }
    }
  }
  
  @Published private(set) var workoutTemplates: [WorkoutTemplate] = [] {
    didSet {
      nonActiveWorkoutTemplates = getNonActiveTemplates()
    }
  }
  
  @Published var activeWorkout: ActiveWorkout? {
    didSet {
      nonActiveWorkoutTemplates = getNonActiveTemplates()
    }
  }
  
  @Published private(set) var nonActiveWorkoutTemplates: [WorkoutTemplate] = []
  @Published private(set) var groupedItems: [String : [Workout]] = [String: [Workout]]()
  
  @Published var workoutInput: WorkoutInput? = nil {
    didSet {
      switch (workoutInput, activeWorkout) {
      case (.template(let template), .none):
        setupPrimaryWorkout(with: template)
      case (.noTemplate, .none):
        setupPrimaryWorkout()
      default:
        break
      }
    }
  }
  
  private let workoutController: NSFetchedResultsController<Workout>
  private let workoutTemplateStore: WorkoutTemplateStore
  private var workoutTemplatesCancellable: AnyCancellable?
  
  init(managedObjectContext: NSManagedObjectContext) {
    workoutTemplateStore = WorkoutTemplateStore(managedObjectContext: managedObjectContext)
    workoutController = NSFetchedResultsController(fetchRequest: Workout.getWorkouts,
    managedObjectContext: managedObjectContext,
    sectionNameKeyPath: nil, cacheName: nil)

    super.init()

    workoutController.delegate = self
    
    workoutTemplatesCancellable = workoutTemplateStore.$items.sink { [weak self] workoutTemplates in
      guard let self = self else { return }
      self.workoutTemplates = workoutTemplates
    }
    
    do {
      try workoutController.performFetch()
      let fetchedItems = workoutController.fetchedObjects ?? []
      workouts = fetchedItems.filter { $0.startTime != nil }
    } catch {
      print("failed to fetch workouts!")
    }
  }
  
  private func setupPrimaryWorkout(with workoutTemplate: WorkoutTemplate) {
    activeWorkout = ActiveWorkout(Workout.getNewWorkout(from: workoutTemplate))
  }
  
  private func setupPrimaryWorkout() {
    activeWorkout = ActiveWorkout(Workout.newWorkoutWithEmptyMeta())
  }
  
  private func resetActiveWorkout() {
    activeWorkout = nil
  }
  
  private func getNonActiveTemplates() -> [WorkoutTemplate] {
    guard let activeWorkout = activeWorkout,
          let meta = activeWorkout.workout.meta else {
      return workoutTemplates
    }
    
    switch activeWorkout.status {
    case .running:
      return workoutTemplates.filter {
        meta !== $0
      }
    default:
      return workoutTemplates
    }
  }
  
  func finishWorkout() -> Void {
   guard let activeWorkout = activeWorkout else { return }
   
   switch (activeWorkout.status)  {
   case .finished where activeWorkout.workout.duration > 0:
    resetActiveWorkout()
   case .finished:
     activeWorkout.workout.deleteWorkout()
    resetActiveWorkout()
   default:
     // a workout is currently going on
     break
   }
 }

}

extension WorkoutStore: NSFetchedResultsControllerDelegate {
  func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    guard let workouts = controller.fetchedObjects as? [Workout]
      else { return }

    self.workouts = workouts.filter {$0.startTime != nil}
  }
}
