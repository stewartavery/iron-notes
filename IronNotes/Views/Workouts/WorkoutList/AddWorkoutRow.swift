//
//  AddWorkoutRow.swift
//  IronNotes
//
//  Created by Stewart Avery on 7/30/19.
//  Copyright © 2019 Stewart Avery. All rights reserved.
//

import SwiftUI

struct AddWorkoutRow: View {
  var body: some View {
    HStack {
      Image(systemName: "plus")
        .workoutImageModifier()
        .foregroundColor(Color.orange)
      VStack(alignment: .leading) {
        Text("Add Workout...")
          .foregroundColor(Color.orange)
          .font(.headline)
      }.padding(.leading, 10)
    }
    .frame(height: 80)
  }
}

#if DEBUG
struct AddWorkoutRow_Previews: PreviewProvider {
  static var previews: some View {
    AddWorkoutRow()
  }
}
#endif
