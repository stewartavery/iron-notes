//
//  WorkoutRow.swift
//  IronNotes
//
//  Created by Stewart Avery on 7/21/19.
//  Copyright © 2019 Stewart Avery. All rights reserved.
//

import SwiftUI

struct WorkoutRow: View {
    var workout: Workout
    
    var body: some View {
        
        HStack {
            Image(self.workout.iconName)
                .resizable()
                .frame(width: 50, height: 50)
                .padding()
                .border(Color.black, width: 1, cornerRadius: 5)
            
            VStack(alignment: .leading) {
                Text(self.workout.name)
                    .font(.headline)
                Text(self.workout.desc)
                    .font(.subheadline)
                Text("Last Workout: " + self.workout.dayDifference(from: self.workout.lastWorkout))
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }.padding(.leading, 10)
        }
        .frame(height: 100)
    }
}



#if DEBUG
struct WorkoutRow_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutRow(workout: workoutData[0])
    }
}
#endif


