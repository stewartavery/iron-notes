//
//  IronNotesApp.swift
//  IronNotes
//
//  Created by Stewart Avery on 9/1/20.
//  Copyright © 2020 Stewart Avery. All rights reserved.
//

import SwiftUI

@main
struct IronNotesApp: App {
  @Environment(\.scenePhase) private var scenePhase

  let persistenceController = PersistenceController.shared
  @StateObject var stopwatchManager = StopwatchManager()
  @StateObject var keyboardMonitor = KeyboardMonitor()
  
  var body: some Scene {
    WindowGroup {
      IronNotesContainer()
        .environment(\.managedObjectContext, persistenceController.container.viewContext)
        .environmentObject(stopwatchManager)
        .environmentObject(keyboardMonitor)
    }
    .onChange(of: scenePhase) { phase in
      if phase == .active {
        DataManager(persistenceController.container.viewContext).setupDefaultData()
      }
    }
  }
}
