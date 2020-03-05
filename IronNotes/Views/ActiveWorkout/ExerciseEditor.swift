//
//  ExerciseEditor.swift
//  IronNotes
//
//  Created by Stewart Avery on 3/1/20.
//  Copyright © 2020 Stewart Avery. All rights reserved.
//

import SwiftUI
import CoreData

struct ExerciseEditor: View {
  var exerciseDetail: ExerciseDetail
  
  var body: some View {
    Section(header: Text(exerciseDetail.wrappedName)) {
      ForEach(exerciseDetail.exerciseSetArray, id: \.self) { exerciseSet in
        HStack {
          Text(String(exerciseSet.weight))
          Spacer()
          Text(String(exerciseSet.reps))
        }
      }
    }
  }
}

struct ExerciseEditor_Previews: PreviewProvider {
  static var previews: some View {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let exerciseDetail = ExerciseDetail(context: context)
    exerciseDetail.name = "Test"
    exerciseDetail.exerciseDetailIndex = 0
    
    let exerciseSet = ExerciseSet(context: context)
    exerciseSet.exerciseSetIndex = 0
    exerciseSet.reps = 3
    exerciseSet.weight = 3
    exerciseDetail.addToSets(exerciseSet)


    return ExerciseEditor(exerciseDetail: exerciseDetail)
  }
}
