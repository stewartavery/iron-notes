//
//  IronNotesTabNavigation.swift
//  IronNotes
//
//  Created by Stewart Avery on 7/21/19.
//  Copyright © 2019 Stewart Avery. All rights reserved.
//

import SwiftUI

struct IronNotesTabNavigation: View {
  var body: some View {
    TabView {
      StartWorkoutList()
        .tabItem({
          VStack {
            Image(systemName: "flame.fill")
            Text("Workouts")
          }
        })
        .tag(0)
      ExerciseList()
        .tabItem({
          VStack {
            Image(systemName: "book.fill")
            Text("Exercises")
          }
        })
        .tag(1)
      WorkoutHistoryContainer()
        .tabItem({
          VStack {
            Image(systemName: "clock.fill")
            Text("History")
          }
        })
        .tag(2)
      Text("Settings")
        .tabItem({
          VStack {
            Image(systemName: "gear")
            Text("Settings")
          }
        })
        .tag(3)
    }
    .accentColor(Color.orange)
  }
}

#if DEBUG
struct IronNotesTabNavigation_Previews: PreviewProvider {
  static var previews: some View {
    return IronNotesTabNavigation()
      .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
  }
}
#endif

