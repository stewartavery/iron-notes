//
//  WorkoutStore.swift
//  IronNotes
//
//  Created by Stewart Avery on 9/8/20.
//  Copyright © 2020 Stewart Avery. All rights reserved.
//

import CoreData

enum WorkoutStatus {
  case stopped, running
}

class WorkoutStore: NSObject, ObservableObject {
  @Published var items: [Workout] = []
  @Published var groupedItems: [DateComponents : [Workout]] = [DateComponents: [Workout]]()
  @Published var primaryWorkout: Workout? = nil
  @Published var workoutStatus: WorkoutStatus = .stopped
  
  private let workoutController: NSFetchedResultsController<Workout>
  
  init(managedObjectContext: NSManagedObjectContext) {
    workoutController = NSFetchedResultsController(fetchRequest: Workout.getWorkouts,
    managedObjectContext: managedObjectContext,
    sectionNameKeyPath: nil, cacheName: nil)

    super.init()

    workoutController.delegate = self

    do {
      try workoutController.performFetch()
      items = workoutController.fetchedObjects ?? []
    } catch {
      print("failed to fetch workouts!")
    }
  }
  
  func setupPrimaryWorkout(with workoutTemplate: WorkoutTemplate) {
    workoutStatus = .stopped
    primaryWorkout = Workout.getNewWorkout(from: workoutTemplate)
  }
  
  func finishPrimaryWorkout() {
    workoutStatus = .stopped
    primaryWorkout = nil
  }
}

extension WorkoutStore: NSFetchedResultsControllerDelegate {
  func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    guard let templates = controller.fetchedObjects as? [Workout]
      else { return }

    items = templates.filter {$0.startTime != nil}
    groupedItems = Dictionary.init(grouping: items) {
      return Calendar.current.dateComponents([.month, .year], from: ($0.startTime)!)
    }
    
    print(groupedItems)
  }
}
