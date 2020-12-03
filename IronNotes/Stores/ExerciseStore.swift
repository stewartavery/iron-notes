//
//  ExerciseStore.swift
//  IronNotes
//
//  Created by Stewart Avery on 11/3/20.
//  Copyright © 2020 Stewart Avery. All rights reserved.
//

import CoreData
import Combine

class ExerciseStore: NSObject, ObservableObject {
  @Published private(set) var exerciseTemplates: [ExerciseTemplate] = []
  @Published private(set) var muscleGroups: [MuscleGroup] = []
  
  @Published private(set) var userCreatedTemplates: [ExerciseTemplate] = [] {
    didSet {
      exerciseTemplates = combineUserAndSeededTemplates(userTemplates: userCreatedTemplates, seededTemplates: seedingStore.templates)
    }
  }
  
  private let exerciseTemplateController: NSFetchedResultsController<ExerciseTemplate>
  private let seedingStore: SeedingStore
  private var templatesCancellable: AnyCancellable?
  private var muscleGroupsCancellable: AnyCancellable?
  
  init(managedObjectContext: NSManagedObjectContext) {
    seedingStore = SeedingStore(managedObjectContext: managedObjectContext)
    exerciseTemplateController = NSFetchedResultsController(
      fetchRequest: ExerciseTemplate.getUserTemplates,
      managedObjectContext: managedObjectContext,
      sectionNameKeyPath: nil,
      cacheName: nil
    )
    
    super.init()
    
    exerciseTemplateController.delegate = self
    
    templatesCancellable = seedingStore.$templates.sink { [weak self] seededTemplates in
      guard let self = self else { return }
      
      self.exerciseTemplates = self.combineUserAndSeededTemplates(
        userTemplates: self.userCreatedTemplates,
        seededTemplates: seededTemplates
      )
    }
    
    muscleGroupsCancellable = seedingStore.$muscleGroups.sink { [weak self] seededMuscleGroups in
      guard let self = self else { return }
      self.muscleGroups = seededMuscleGroups
    }
    
    do {
      try exerciseTemplateController.performFetch()
      userCreatedTemplates = exerciseTemplateController.fetchedObjects ?? []
    } catch {
      print("failed to fetch workout templates!")
    }
  }
  
  private func combineUserAndSeededTemplates(userTemplates: [ExerciseTemplate], seededTemplates: [ExerciseTemplate]) -> [ExerciseTemplate] {
    let combinedTemplates = userTemplates + seededTemplates
    
    return combinedTemplates.sorted {
      $0.displayName < $1.displayName
    }
  }
}

extension ExerciseStore: NSFetchedResultsControllerDelegate {
  func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    guard let templates = controller.fetchedObjects as? [ExerciseTemplate]
    else { return }
    
    userCreatedTemplates = templates
  }
}
