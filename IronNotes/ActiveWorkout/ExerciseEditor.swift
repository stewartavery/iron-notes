//
//  ExerciseEditor.swift
//  IronNotes
//
//  Created by Stewart Avery on 3/1/20.
//  Copyright © 2020 Stewart Avery. All rights reserved.
//

import SwiftUI

struct ExerciseEditor: View {
  var exercise: ExerciseDetail
  
  var body: some View {
    Section(header: Text(exercise.name ?? "")) {
      ForEach(exercise.sets, id: \.exerciseSetId) { exerciseSet in
        HStack {
          Text(String(exerciseSet.weight ?? 0))
          Spacer()
          Text(String(exerciseSet.reps ?? 3))
        }
      }
    }
  }
}


//struct ExerciseEditor_Previews: PreviewProvider {
//    static var previews: some View {
//        ExerciseEditor()
//    }
//}
