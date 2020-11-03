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
  @Published private(set) var items: [Workout] = []
  @Published private(set) var groupedItems: [String : [Workout]] = [String: [Workout]]()
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
      let fetchedItems = workoutController.fetchedObjects ?? []
      items = fetchedItems.filter { $0.startTime != nil }
    
      createGroupedList(with: items)
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
    
    print(groupedItems)
  }
}
