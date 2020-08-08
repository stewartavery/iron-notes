//
//  IronNotesContainer.swift
//  IronNotes
//
//  Created by Stewart Avery on 7/21/19.
//  Copyright © 2019 Stewart Avery. All rights reserved.
//

import SwiftUI

struct IronNotesContainer: View {
  @StateObject var stopwatchManager = StopwatchManager()
  
  var body: some View {
    TabView {
      StartWorkoutList()
        .font(.title)
        .tabItem({
          VStack {
            Image(systemName: "flame.fill")
            Text("Workouts")
          }
        })
        .tag(0)
      ExerciseList()
        .font(.title)
        .tabItem({
          VStack {
            Image(systemName: "book.fill")
            Text("Exercises")
          }
        })
        .tag(1)
      Text("History")
        .font(.title)
        .tabItem({
          VStack {
            Image(systemName: "clock.fill")
            Text("History")
          }
        })
        .tag(2)
      Text("Settings")
        .font(.title)
        .tabItem({
          VStack {
            Image(systemName: "gear")
            Text("Settings")
          }
        })
        .tag(3)
    }.environmentObject(stopwatchManager)
  }
}

#if DEBUG
struct IronNotesContainer_Previews: PreviewProvider {
  static var previews: some View {
    return IronNotesContainer()
      .environment(\.managedObjectContext, AppDelegate.viewContext)
  }
}
#endif

