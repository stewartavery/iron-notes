//
//  CompletionCircle.swift
//  IronNotes
//
//  Created by Stewart Avery on 6/6/20.
//  Copyright © 2020 Stewart Avery. All rights reserved.
//

import SwiftUI

struct CompletionCircle: View {
  @ObservedObject var exerciseSet: ExerciseSet

  var body: some View {
    Button {
      toggleIsCompleted()
    } label: {
      if exerciseSet.isCompleted {
        Image(systemName: "largecircle.fill.circle")
          .rowIconCircle()
      } else {
        Image(systemName: "circle")
          .rowIconCircle()
          .foregroundColor(Color.gray)
      }
    }
  }
  
  func toggleIsCompleted() {
    exerciseSet.isCompleted.toggle()
  }
}

#if DEBUG
struct ComplettionCircle_Previews: PreviewProvider {
  static var previews: some View {
    return CompletionCircle(exerciseSet: IronNotesModelFactory.getExerciseSet())
  }
}
#endif
