//
//  StartWorkoutList.swift
//  IronNotes
//
//  Created by Stewart Avery on 7/3/19.
//  Copyright © 2019 Stewart Avery. All rights reserved.
//

import SwiftUI

struct StartWorkoutList : View {
  @Environment(\.managedObjectContext) var moc
  @FetchRequest(entity: Workout.entity(), sortDescriptors: []) var workouts: FetchedResults<Workout>
  
  init() {
    // To remove only extra separators below the list:
    //      UITableView.appearance().tableFooterView = UIView()
    
    // To remove all separators including the actual ones:
    //      UITableView.appearance().separatorStyle = .none
  }
  
  var body: some View {
    NavigationView {
      List {
        ForEach(workouts, id: \.id) { workout in
          NavigationLink(destination: ActiveWorkout(workout: workout)) {
            WorkoutRow(workout: workout)
          }
          .listRowInsets(EdgeInsets(top: 23, leading: 0, bottom: 0, trailing: 0))
        }
        
        
        NavigationLink(destination: NewWorkout()) {
          AddWorkoutRow()
        }
        
      }
      .onAppear() {
        UITableView.appearance().tableFooterView = UIView()
        UITableView.appearance().separatorInset = UIEdgeInsets(top: 0, left: 115, bottom: 0, right: 0)
      }
      .navigationBarTitle("Start Your Workout", displayMode: .large)
      .accentColor(Color.green)
      
    }
    
  }
}

#if DEBUG
struct StartWorkoutuList_Preview : PreviewProvider {
  static var previews: some View {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    return StartWorkoutList().environment(\.managedObjectContext, context)
    
  }
}
#endif

