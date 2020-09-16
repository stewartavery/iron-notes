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
  @StateObject var workoutTemplateStore: WorkoutTemplateStore
  @StateObject var workoutStore: WorkoutStore
  
  init() {
    persistenceController = PersistenceController.shared
    
    _keyboardMonitor = StateObject(wrappedValue: KeyboardMonitor())
    
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
      switch phase {
      case .active:
        if isFirstTime {
          DataManager(moc)
            .setupDefaultData()
          isFirstTime.toggle()
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
