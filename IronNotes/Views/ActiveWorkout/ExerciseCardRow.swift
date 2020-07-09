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
    VStack {
      Spacer()
      HStack(alignment: .center, spacing: LARGE_SPACING) {
        CompletionCircle()
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
      }
      Spacer()
      Divider()
    }
  }
}

struct AddSet: View {
  var body: some View {
    // Replace with label when alignment is fixed
    //    Label("Add Set", systemImage: "plus.circle.fill")
    //      .foregroundColor(Color.orange)
    HStack(alignment: .center, spacing: LARGE_SPACING) {
      Image(systemName: "plus.circle.fill")
        .foregroundColor(Color.orange)
      Text("Add Set")
        .font(.headline)
        .foregroundColor(Color.orange)
      Spacer()
    }.frame(height: 33)
    .padding(.bottom, 10)
  }
}

