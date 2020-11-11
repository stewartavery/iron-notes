//
//  ExerciseCardRow.swift
//  IronNotes
//
//  Created by Stewart Avery on 7/9/20.
//  Copyright © 2020 Stewart Avery. All rights reserved.
//

import SwiftUI

let spacing: CGFloat = 50

struct ExerciseCardRow: View {
  @ObservedObject var exerciseSet: ExerciseSet
  var isActive: Bool
  
  var reps: Binding<String> {
    return Binding<String>(get: {
      String(exerciseSet.reps)
    }, set: { value in
      exerciseSet.reps = Int16(value) ?? 0
    })
  }
  
  var weight: Binding<String> {
    return Binding<String>(get: {
      String(exerciseSet.weight)
    }, set: {
      exerciseSet.weight = Int32($0) ?? 0
    })
  }
  
  var body: some View {
    HStack(alignment: .center) {
      if isActive {
        CompletionCircle(exerciseSet: exerciseSet)
      }
      
      Text("Set \(exerciseSet.setPosition + 1):")
        .foregroundColor(Color.gray)
      
      Spacer()
      
      HStack(alignment: .firstTextBaseline) {
        
        TextField("lbs", text: weight)
          .keyboardType(.decimalPad)
          .multilineTextAlignment(.trailing)
          .frame(maxWidth: 45)
          .font(.headline)
          .disabled(!isActive)
        
        Text("lbs")
          .font(.caption)
          .foregroundColor(Color.gray)
        
        Image(systemName: "multiply")
          .foregroundColor(Color.gray)
          .font(.headline)
          .padding(.leading)
        
        TextField("reps", text: reps)
          .keyboardType(.decimalPad)
          .multilineTextAlignment(.trailing)
          .frame(maxWidth: 30)
          .font(.headline)
          .disabled(!isActive)
        
        
        Text("reps")
          .font(.caption)
          .foregroundColor(Color.gray)
      }
    }    
  }
}

#if DEBUG
struct ExerciseCardRow_Previews: PreviewProvider {
  static var previews: some View {
    return ExerciseCardRow(exerciseSet: IronNotesModelFactory.getExerciseSet(), isActive: true)
  }
}
#endif
