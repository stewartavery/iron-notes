//
//  StartWorkoutList.swift
//  IronNotes
//
//  Created by Stewart Avery on 7/3/19.
//  Copyright © 2019 Stewart Avery. All rights reserved.
//

import SwiftUI

struct StartWorkoutList : View {
    var workouts: [Workout]
    
    var body: some View {
        NavigationView {
            List(workouts) { workout in
                WorkoutRow(workout: workout)
            }.navigationBarItems(trailing:
                Button(action: {
                    // Add action
                }, label: {
                    Text("Add")
                })
            )
            .navigationBarTitle("Start Workout", displayMode: .large)
        }
    }
}

#if DEBUG
struct StartWorkoutuList_Preview : PreviewProvider {
    static var previews: some View {
        StartWorkoutList(workouts: workoutData)
    }
}
#endif
