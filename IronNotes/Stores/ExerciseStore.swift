//
//  ExerciseStore.swift
//  IronNotes
//
//  Created by Stewart Avery on 10/29/20.
//  Copyright © 2020 Stewart Avery. All rights reserved.
//

import CoreData

class ExerciseStore: NSObject, ObservableObject {
  @Published var templates: [ExerciseTemplate] = []
  
  private let exerciseTemplateController: NSFetchedResultsController<ExerciseTemplate>
  
  init(managedObjectContext: NSManagedObjectContext) {
    exerciseTemplateController = NSFetchedResultsController(
      fetchRequest: ExerciseTemplate.getTemplates,
      managedObjectContext: managedObjectContext,
      sectionNameKeyPath: nil, cacheName: nil
    )
    super.init()
    
    exerciseTemplateController.delegate = self
    
    do {
      try exerciseTemplateController.performFetch()
      templates = exerciseTemplateController.fetchedObjects ?? []
    } catch {
      print("failed to fetch exercise templates!")
    }
  }
}

extension ExerciseStore: NSFetchedResultsControllerDelegate {
  func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    guard let templates = controller.fetchedObjects as? [ExerciseTemplate]
    else { return }
    
    self.templates = templates
  }
}
