//
//  WorkoutStore.swift
//  IronNotes
//
//  Created by Stewart Avery on 9/8/20.
//  Copyright © 2020 Stewart Avery. All rights reserved.
//

import CoreData

class WorkoutStore: NSObject, ObservableObject {
  @Published var items: [Workout] = []
  @Published var primaryWorkout: Workout? = nil
  
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
    primaryWorkout = Workout.getNewWorkout(from: workoutTemplate)
  }
  
  func finishPrimaryWorkout() {
    primaryWorkout = nil
  }
}

extension WorkoutStore: NSFetchedResultsControllerDelegate {
  func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    guard let templates = controller.fetchedObjects as? [Workout]
      else { return }

    items = templates
  }
}
