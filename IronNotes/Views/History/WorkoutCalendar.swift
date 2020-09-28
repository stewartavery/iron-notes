//
//  WorkoutCalendar.swift
//  IronNotes
//
//  Created by Stewart Avery on 9/27/20.
//  Copyright © 2020 Stewart Avery. All rights reserved.
//

import SwiftUI

struct WorkoutCalendar: View {
  @State private var tabSelection = 3
  
  var body: some View {
    TabView(selection: $tabSelection) {
      Text("first page")
        .tag(1)
      Text("second page")
        .tag(2)
      Text("third page")
        .tag(3)
    }
    .tabViewStyle(PageTabViewStyle())
  }
}

struct WorkoutCalendar_Previews: PreviewProvider {
  static var previews: some View {
    WorkoutCalendar()
  }
}
