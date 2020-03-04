//
//  IronNotesContainer.swift
//  IronNotes
//
//  Created by Stewart Avery on 7/21/19.
//  Copyright © 2019 Stewart Avery. All rights reserved.
//

import SwiftUI

struct IronNotesContainer: View {
  var body: some View {
    TabView {
      StartWorkoutList()
        .font(.title)
        .tabItem({
          VStack {
            Image(systemName: "smiley.fill")
            Text("Workouts")
          }
        })
        .tag(0)
      Text("History")
        .font(.title)
        .tabItem({
          VStack {
            Image(systemName: "clock.fill")
            Text("History")
          }
        })
        .tag(1)
      Text("Settings")
        .font(.title)
        .tabItem({
          VStack {
            Image(systemName: "gear")
            Text("Settings")
          }
        })
        .tag(2)
      
    }
  }
}

#if DEBUG
struct IronNotesContainer_Previews: PreviewProvider {
  static var previews: some View {
    IronNotesContainer()
  }
}
#endif

