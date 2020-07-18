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
    Button(action: toggleIsCompleted) {
      if exerciseSet.isCompleted {
        Image(systemName: "largecircle.fill.circle")
      } else {
        Image(systemName: "circle")
          .foregroundColor(Color.gray)
      }
    }
  }
  
  func toggleIsCompleted() {
    exerciseSet.isCompleted.toggle()
  }
}
