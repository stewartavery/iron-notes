//
//  ExerciseCardRow.swift
//  IronNotes
//
//  Created by Stewart Avery on 7/9/20.
//  Copyright © 2020 Stewart Avery. All rights reserved.
//

import SwiftUI

let SMALL_SPACING: CGFloat = 3

struct ExerciseCardRow: View {
  @ObservedObject var exerciseSet: ExerciseSet
  
  var body: some View {
    let weightBinding = Binding<String>(get: {
      String(self.exerciseSet.weight)
    }, set: {
      self.exerciseSet.weight = Int32($0) ?? 0
    })
    
    let repBinding = Binding<String>(get: {
      String(self.exerciseSet.reps)
    }, set: { value in
      self.exerciseSet.reps = Int16(value) ?? 0
    })
    
    HStack(alignment: .center) {
      CompletionCircle(exerciseSet: exerciseSet)
      
      HStack {
        Text("Set \(exerciseSet.setPosition + 1):")
          .foregroundColor(Color.gray)
        
        Spacer()
        
        HStack(spacing: 25) {
          HStack(alignment: .firstTextBaseline, spacing: SMALL_SPACING) {
            TextField("lbs", text: weightBinding)
              .keyboardType(.decimalPad)
              .multilineTextAlignment(.trailing)
              .frame(maxWidth: 45)
              .font(.headline)
            
            Text("lbs")
              .font(.caption)
              .foregroundColor(Color.gray)
          }
          
          Image(systemName: "multiply")
            .foregroundColor(Color.gray)
            .font(.headline)
          
          HStack(alignment: .firstTextBaseline, spacing: SMALL_SPACING) {
            TextField("reps", text: repBinding)
              .keyboardType(.decimalPad)
              .multilineTextAlignment(.trailing)
              .frame(maxWidth: 30)
              .font(.headline)
            
            
            Text("reps")
              .font(.caption)
              .foregroundColor(Color.gray)
          }
        }
      }
    }
    .frame(height: 20)
    
  }
}

#if DEBUG
struct ExerciseCardRow_Previews: PreviewProvider {
  static var previews: some View {
    return ExerciseCardRow(exerciseSet: IronNotesModelFactory.getExerciseSet())
  }
}
#endif
