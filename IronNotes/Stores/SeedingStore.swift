//
//  SeedingStore.swift
//  IronNotes
//
//  Created by Stewart Avery on 10/29/20.
//  Copyright © 2020 Stewart Avery. All rights reserved.
//

import CoreData

class SeedingStore: NSObject, ObservableObject {
  @Published private(set) var templates: [ExerciseTemplate] = []
  @Published private(set) var muscleGroups: [MuscleGroup] = []
  
  private let managedObjectContext: NSManagedObjectContext
  private let seedingGroupController: NSFetchedResultsController<SeedingGroup>
  
  init(managedObjectContext: NSManagedObjectContext) {

    self.managedObjectContext = managedObjectContext
    
    seedingGroupController = NSFetchedResultsController(
      fetchRequest: SeedingGroup.getGroups,
      managedObjectContext: managedObjectContext,
      sectionNameKeyPath: nil, cacheName: nil
    )
    
    super.init()
    
    seedingGroupController.delegate = self
    
    do {
      try seedingGroupController.performFetch()
      let unfilteredGroups = seedingGroupController.fetchedObjects ?? []
    
      handleDuplicateSeeding(for: unfilteredGroups)
    } catch {
      print("failed to fetch seeding groups!")
    }
  }

  /** If there's more than one container with the same version, then we have a duplicate seeding issue .*/
  private func handleDuplicateSeeding(for groups: [SeedingGroup]) {
    if groups.count == 0 {
      return
    }
    
    var groupsToBeMerged = groups.sorted {
      $0.wrappedDateCreated < $1.wrappedDateCreated
    }

    let baseGroup = groupsToBeMerged.removeFirst()
    
    if groupsToBeMerged.count >= 1 {
      let muscleGroupMap = Dictionary(uniqueKeysWithValues: baseGroup.muscleGroupsArray.map {
        ($0.wrappedName, $0)
      })
      
      let exerciseTemplateMap = Dictionary(uniqueKeysWithValues: baseGroup.exerciseTemplateArray.map {
        ($0.wrappedId, $0)
      })

      // All of these containers (duplicates) need to be have their values transferred to the base seeding container
      groupsToBeMerged.forEach { container in
        container.muscleGroupsArray.forEach { muscleGroup in
          // I only care about taking care of the exerciseTemplates that don't appear in the "container".
          // All others are about to be removed.
          muscleGroup.exerciseTemplateArray
            .filter { exerciseTemplateMap[$0.wrappedId] == nil }
            .forEach { exerciseTemplate in
              if let originalMuscleGroup = muscleGroupMap[muscleGroup.wrappedName] {
                exerciseTemplate.addToMuscleGroups(originalMuscleGroup)
              } else {
                print("Could not find original muscle group \(muscleGroup.wrappedName)")
              }
              
              exerciseTemplate.removeFromMuscleGroups(muscleGroup)
            }
        }
       
        container.exerciseTemplateArray.forEach { exerciseTemplate in
          exerciseTemplate.exerciseArray.forEach { exercise in
            if let originalExerciseTemplate = exerciseTemplateMap[exerciseTemplate.wrappedId] {
              exercise.meta = originalExerciseTemplate
            } else {
              print("Could not find exerciseTemplate \(exerciseTemplate.wrappedName) for id: \(exerciseTemplate.wrappedId)")
            }
          }
        }
        
        // this should cascade down to seeded templates/muscle groups
        managedObjectContext.delete(container)
      }
      
      try! managedObjectContext.save()
    }
    
    templates = baseGroup.exerciseTemplateArray
    muscleGroups = baseGroup.muscleGroupsArray
  }
}

extension SeedingStore: NSFetchedResultsControllerDelegate {
  func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    guard let unfilteredGroups = controller.fetchedObjects as? [SeedingGroup]
    else { return }
    
    handleDuplicateSeeding(for: unfilteredGroups)
  }
}
