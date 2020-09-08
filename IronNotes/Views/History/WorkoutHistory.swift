//
//  WorkoutHistory.swift
//  IronNotes
//
//  Created by Stewart Avery on 9/2/20.
//  Copyright © 2020 Stewart Avery. All rights reserved.
//

import SwiftUI

struct WorkoutHistory: View {
  @FetchRequest(
    entity: Workout.entity(),
    sortDescriptors: []
  ) var workouts: FetchedResults<Workout>
  
  var body: some View {
    NavigationView {
      ScrollView {
        VStack(alignment: .leading) {
          ForEach(workouts, id: \.self) { workout in
            HStack {
            VStack(alignment: .leading) {
              Text(workout.meta.name)
              Text(workout.readableDate)
            }
              Spacer()
            }
  
          }
        }
        .padding()
      }
      .navigationBarTitle("History")
    }
  }
}

struct WorkoutHistory_Previews: PreviewProvider {
  static var previews: some View {
    WorkoutHistory()
      .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
  }
}
