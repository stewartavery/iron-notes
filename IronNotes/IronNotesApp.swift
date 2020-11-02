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
  @AppStorage("hasUnsavedDefaultData") var hasNewDefaultData: Bool = false
  
  
  @Environment(\.scenePhase) private var scenePhase
  
  let persistenceController: PersistenceController
  
  @StateObject var keyboardMonitor: KeyboardMonitor
  @StateObject var workoutTemplateStore: WorkoutTemplateStore
  @StateObject var workoutStore: WorkoutStore
  @StateObject var hasDefaultDataSyncedMonitor: UbiquitousMonitor
  
  init() {
    persistenceController = PersistenceController.shared
    
    _keyboardMonitor = StateObject(wrappedValue: KeyboardMonitor())
    _hasDefaultDataSyncedMonitor = StateObject(wrappedValue: UbiquitousMonitor(key: .didSyncDefaultData))
    
    let templateStorage = WorkoutTemplateStore(managedObjectContext: persistenceController.container.viewContext)
    let workoutStorage = WorkoutStore(managedObjectContext: persistenceController.container.viewContext)
    
    _workoutTemplateStore = StateObject(wrappedValue: templateStorage)
    _workoutStore = StateObject(wrappedValue: workoutStorage)
  }
  
  var moc: NSManagedObjectContext {
    persistenceController.container.viewContext
  }
  
  var body: some Scene {
    WindowGroup {
      IronNotesTabNavigation()
        .environment(\.managedObjectContext, moc)
        .environmentObject(keyboardMonitor)
        .environmentObject(workoutTemplateStore)
        .environmentObject(workoutStore)
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
          hasNewDefaultData.toggle()
        }
        break
      case .background:
        persistenceController.saveContext()
        break
      default:
        break
      }
    }
    .onChange(of: hasDefaultDataSyncedMonitor.value) { hasDefaultDataSynced in
      CKContainer.default().accountStatus { status, error in
        print(status)
        if let error = error {
          print(error)
        } else {
          switch status {
          case .available:
            // synced, unhandled (which means the update came from server), and has newDefaultData
            if hasDefaultDataSynced && hasDefaultDataSyncedMonitor.hasUnhandledValue && hasNewDefaultData {
              print("I should delete the new default data now")
              
              hasNewDefaultData.toggle()
            }
          default:
            return
          }
        }
      }
      
    }
  }
}
