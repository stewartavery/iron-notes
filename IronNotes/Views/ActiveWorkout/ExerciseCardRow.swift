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
  let accessoryViewController = InlineAccessoryViewController()
  let font = UIFont.systemFont(ofSize: 20)
  
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
          InlineTextField("Weight", text: weightBinding)
            .font(font)
            .accessoryViewController(accessoryViewController, tag: 0)
            .frame(width: 40)
            .padding(.leading, 10)
          
          Text("lbs")
            .font(.caption)
            .foregroundColor(Color.gray)
        }
        
        Image(systemName: "multiply")
          .foregroundColor(Color.gray)
          .font(.headline)
        
        HStack(alignment: .firstTextBaseline, spacing: SMALL_SPACING) {
          InlineTextField("Reps", text: repBinding)
            .font(font)
            .accessoryViewController(accessoryViewController, tag: 1)
            .frame(width: 30)
            .padding(.leading, 10)
          
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

#if DEBUG
struct ExerciseCardRow_Previews: PreviewProvider {
  static var previews: some View {
    return ExerciseCardRow(exerciseSet: IronNotesModelFactory.getExerciseSet())
  }
}
#endif
