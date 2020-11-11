//
//  WorkoutStore.swift
//  IronNotes
//
//  Created by Stewart Avery on 9/8/20.
//  Copyright © 2020 Stewart Avery. All rights reserved.
//

import CoreData

class WorkoutStore: NSObject, ObservableObject {
  @Published private(set) var items: [Workout] = []
  @Published private(set) var groupedItems: [String : [Workout]] = [String: [Workout]]()
  @Published var activeWorkout: ActiveWorkout?
  
  private let workoutController: NSFetchedResultsController<Workout>
  
  init(managedObjectContext: NSManagedObjectContext) {
    workoutController = NSFetchedResultsController(fetchRequest: Workout.getWorkouts,
    managedObjectContext: managedObjectContext,
    sectionNameKeyPath: nil, cacheName: nil)

    super.init()

    workoutController.delegate = self

    do {
      try workoutController.performFetch()
      let fetchedItems = workoutController.fetchedObjects ?? []
      items = fetchedItems.filter { $0.startTime != nil }
    
      createGroupedList(with: items)
    } catch {
      print("failed to fetch workouts!")
    }
  }
  
  func setupPrimaryWorkout(with workoutTemplate: WorkoutTemplate) {
    activeWorkout = ActiveWorkout(Workout.getNewWorkout(from: workoutTemplate))
  }
  
  func setupPrimaryWorkout() {
    activeWorkout = ActiveWorkout(Workout.newWorkoutWithEmptyMeta())
  }
  
  func finishPrimaryWorkout() {
    activeWorkout = nil
  }
  
  func createGroupedList(with workouts: [Workout]) -> Void {
    self.groupedItems = Dictionary.init(grouping: workouts) {
      let comps = Calendar.current.dateComponents([.month, .year], from: $0.wrappedStartTime)
      return String(format: "%ld-%.2ld", comps.year!, comps.month!)
    }
  }
}

extension WorkoutStore: NSFetchedResultsControllerDelegate {
  func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    guard let templates = controller.fetchedObjects as? [Workout]
      else { return }

    items = templates.filter {$0.startTime != nil}

    createGroupedList(with: items)
  }
}
