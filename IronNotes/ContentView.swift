//
//  StartWorkoutList.swift
//  IronNotes
//
//  Created by Stewart Avery on 7/3/19.
//  Copyright © 2019 Stewart Avery. All rights reserved.
//

import SwiftUI

struct StartWorkoutList : View {
    var body: some View {
        NavigationView {
            List {
                WorkoutRow(label: "Push", desc: "Bench Press, Press, Extensions", icon: "dumbbell", lastWorkout: Date())
                
                WorkoutRow(label: "Pull", desc: "Deadlift, Barbell Row, Bicep Curl", icon: "arm-muscles-silhouette", lastWorkout: Date().advanced(by: -100000))
                WorkoutRow(label: "Legs", desc: "Squats, RDL, Hack Squat", icon: "barbell", lastWorkout: Date().advanced(by: -200000))
            }
            .navigationBarItems(trailing:
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
        StartWorkoutList()
    }
}
#endif
