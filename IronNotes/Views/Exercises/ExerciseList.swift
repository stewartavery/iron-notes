//
//  ExerciseList.swift
//  IronNotes
//
//  Created by Stewart Avery on 4/13/20.
//  Copyright © 2020 Stewart Avery. All rights reserved.
//

import SwiftUI

struct ExerciseList: View {
  @Environment(\.managedObjectContext) var moc
  @FetchRequest(entity: Exercise.entity(), sortDescriptors: []) var exercises: FetchedResults<Exercise>
  
  var body: some View {
    NavigationView {
      List {
        ForEach(exercises, id: \.self) { exercise in
          Text(exercise.name)
        }
      }
    }
  }
}

struct ExerciseList_Previews: PreviewProvider {
  static var previews: some View {
    ExerciseList()
      .environment(\.managedObjectContext, AppDelegate.viewContext)
      .onAppear() {
        
    }
  }
}

