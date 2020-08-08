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
    let weightBinding = Binding<String>(get: {
      String(self.exerciseSet.weight)
    }, set: {
      print("weight!!!")
      self.exerciseSet.weight = Int32($0) ?? 0
    })
    
    let repBinding = Binding<String>(get: {
      String(self.exerciseSet.reps)
    }, set: {
      self.exerciseSet.reps = Int16($0) ?? 0
    })
    
    HStack(alignment: .center, spacing: LARGE_SPACING) {
      Label {
        HStack(alignment: .firstTextBaseline, spacing: SMALL_SPACING) {
          
          TextField("", text: weightBinding)
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
          TextField("", text: repBinding)
            .font(.headline)
            .keyboardType(.decimalPad)
            .frame(width: 13)
          
          Text("reps")
            .font(.caption)
            .foregroundColor(Color.gray)
        }
        Spacer()
      } icon: {
        CompletionCircle(exerciseSet: exerciseSet)
      }
    }.frame(height: 20)
    
  }
}

struct ExerciseCardRow_Previews: PreviewProvider {
  static var previews: some View {
    return ExerciseCardRow(exerciseSet: IronNotesModelFactory.getExerciseSet())
  }
}
