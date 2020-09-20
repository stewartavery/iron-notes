//
//  WorkoutHistoryContainer.swift
//  IronNotes
//
//  Created by Stewart Avery on 9/17/20.
//  Copyright © 2020 Stewart Avery. All rights reserved.
//

import SwiftUI

struct WorkoutHistoryContainer: View {
    @EnvironmentObject var workoutStore: WorkoutStore
    
    var body: some View {
      WorkoutHistory(groupedWorkouts: workoutStore.groupedItems)
    }
}
