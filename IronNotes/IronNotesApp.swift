//
//  IronNotesApp.swift
//  IronNotes
//
//  Created by Stewart Avery on 9/1/20.
//  Copyright © 2020 Stewart Avery. All rights reserved.
//

import SwiftUI
import CoreData

@main
struct IronNotesApp: App {
  @AppStorage("isFirstTime") var isFirstTime: Bool = true
  
  @Environment(\.scenePhase) private var scenePhase
  
  let persistenceController: PersistenceController
  
  @StateObject var keyboardMonitor: KeyboardMonitor
  @StateObject var workoutStore: WorkoutStore
  @StateObject var exerciseStore: ExerciseStore
  @StateObject var hasDefaultDataSyncedMonitor: UbiquitousMonitor
  
  init() {
    persistenceController = PersistenceController.shared
    
    _keyboardMonitor = StateObject(wrappedValue: KeyboardMonitor())
    _hasDefaultDataSyncedMonitor = StateObject(wrappedValue: UbiquitousMonitor(key: .didSyncDefaultData))
    
 
    let workoutStorage = WorkoutStore(managedObjectContext: persistenceController.container.viewContext)
    let exerciseStorage = ExerciseStore(managedObjectContext: persistenceController.container.viewContext)
    
    _workoutStore = StateObject(wrappedValue: workoutStorage)
    _exerciseStore = StateObject(wrappedValue: exerciseStorage)
  }
  
  var moc: NSManagedObjectContext {
    persistenceController.container.viewContext
  }
  
  var body: some Scene {
    WindowGroup {
      SummaryContainer()
        .environment(\.managedObjectContext, moc)
        .environmentObject(keyboardMonitor)
        .environmentObject(workoutStore)
        .accentColor(.orange)
    }
    .onChange(of: scenePhase) { phase in
      print(hasDefaultDataSyncedMonitor.value)
      print("in scene phase")
      
      switch phase {
      case .active:
        if isFirstTime && !hasDefaultDataSyncedMonitor.value {
          DataManager(moc)
            .setupDefaultData()
          
          isFirstTime.toggle()
          hasDefaultDataSyncedMonitor.value = true
        }
        break
      case .background:
        persistenceController.saveContext()
        break
      default:
        break
      }
    }
  }
}
