//
//  SummaryContainer.swift
//  IronNotes
//
//  Created by Stewart Avery on 11/29/20.
//  Copyright © 2020 Stewart Avery. All rights reserved.
//

import SwiftUI

struct SummaryContainer: View {
  @EnvironmentObject var workoutStore: WorkoutStore
  
  var body: some View {
    SummaryView(workouts: workoutStore.summaryItems)
  }
}


