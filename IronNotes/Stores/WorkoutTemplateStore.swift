//
//  WorkoutTemplateStore.swift
//  IronNotes
//
//  Created by Stewart Avery on 9/8/20.
//  Copyright © 2020 Stewart Avery. All rights reserved.
//

import CoreData

class WorkoutTemplateStore: NSObject, ObservableObject {
  @Published private(set) var items: [WorkoutTemplate] = []
  
  private let workoutTemplateController: NSFetchedResultsController<WorkoutTemplate>

  init(managedObjectContext: NSManagedObjectContext) {
    workoutTemplateController = NSFetchedResultsController(fetchRequest: WorkoutTemplate.getTemplates,
    managedObjectContext: managedObjectContext,
    sectionNameKeyPath: nil, cacheName: nil)

    super.init()

    workoutTemplateController.delegate = self

    do {
      try workoutTemplateController.performFetch()
      items = workoutTemplateController.fetchedObjects ?? []
    } catch {
      print("failed to fetch workout templates!")
    }
  }
}

extension WorkoutTemplateStore: NSFetchedResultsControllerDelegate {
  func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    guard let templates = controller.fetchedObjects as? [WorkoutTemplate]
      else { return }

    items = templates
  }
}
