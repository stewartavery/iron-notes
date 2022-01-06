//
//  ExerciseCardRow.swift
//  IronNotes
//
//  Created by Stewart Avery on 7/9/20.
//  Copyright © 2020 Stewart Avery. All rights reserved.
//

import SwiftUI

let spacing: CGFloat = 50

enum ExerciseCardRowField: Hashable {
  case weight
  case reps
}

struct ExerciseCardRow: View {
  @ObservedObject var exerciseSet: ExerciseSet
  @FocusState private var focusedField: ExerciseCardRowField?
  @Binding var activeRowIndex: Int

  var isActive: Bool
  var index: Int
    
  private var reps: Binding<String> {
    return Binding<String>(get: {
      String(exerciseSet.reps)
    }, set: { value in
      exerciseSet.reps = Int16(value) ?? 0
    })
  }
  
  private var weight: Binding<String> {
    return Binding<String>(get: {
      String(exerciseSet.weight)
    }, set: {
      exerciseSet.weight = Int32($0) ?? 0
    })
  }
  
  func clearFocus() {
    focusedField = nil
  }
  
  func setActiveRow() {
    focusedField = .weight
  }
  
  var body: some View {
    HStack(alignment: .center) {
      if isActive {
        CompletionCircle(exerciseSet: exerciseSet, onComplete: clearFocus)
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
          .focused($focusedField, equals: .weight)
        
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
          .focused($focusedField, equals: .reps)
        
        Text("reps")
          .font(.caption)
          .foregroundColor(Color.gray)
      }
    }.toolbar {
      ToolbarItem(placement: .keyboard) {
        Button("next") {
          focusedField = .reps
        }
      }
    }.onChange(of: activeRowIndex) { activeIndex in
      if(activeIndex == index) {
        setActiveRow()
      }
    }
  }
}

#if DEBUG
//struct ExerciseCardRow_Previews: PreviewProvider {
//  static var previews: some View {
////    return ExerciseCardRow(exerciseSet: IronNotesModelFactory.getExerciseSet(), isActive: true)
//  }
//}
#endif

