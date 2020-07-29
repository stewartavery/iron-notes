//
//  ExerciseCardRow.swift
//  IronNotes
//
//  Created by Stewart Avery on 7/9/20.
//  Copyright © 2020 Stewart Avery. All rights reserved.
//

import SwiftUI

let LARGE_SPACING: CGFloat = 12
let SMALL_SPACING: CGFloat = 2

struct ExerciseCardRow: View {
  @ObservedObject var exerciseSet: ExerciseSet
  
  var body: some View {
    HStack(alignment: .center, spacing: LARGE_SPACING) {
      CompletionCircle(exerciseSet: exerciseSet)
      HStack(alignment: .firstTextBaseline, spacing: SMALL_SPACING) {
        
        TextField("", value: $exerciseSet.weight, formatter: NumberFormatter())
          .font(.headline)
          .keyboardType(.decimalPad)
          .frame(width: 32)
        
        Text("lbs")
          .font(.caption)
          .foregroundColor(Color.gray)
      }
      
      Image(systemName: "multiply")
        .foregroundColor(Color.gray)
      
      HStack(alignment: .firstTextBaseline, spacing: SMALL_SPACING) {
        TextField("", value: $exerciseSet.reps, formatter: NumberFormatter())
          .font(.headline)
          .keyboardType(.decimalPad)
          .frame(width: 13)
        
        Text("reps")
          .font(.caption)
          .foregroundColor(Color.gray)
      }
      Spacer()
    }.frame(height: 20)
    
  }
}

struct ExerciseCardRow_Previews: PreviewProvider {
  static var previews: some View {
    let exerciseSet = ExerciseSet(context: AppDelegate.viewContext)
    exerciseSet.setPosition = 0
    exerciseSet.reps = 3
    exerciseSet.weight = 135
    
    return ExerciseCardRow(exerciseSet: exerciseSet)
  }
}
