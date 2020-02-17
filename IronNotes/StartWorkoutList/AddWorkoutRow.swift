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
      RowImage(iconName: "add")
      
      VStack(alignment: .leading) {
        Text("Add Workout...")
          .font(.headline)
          .foregroundColor(
            .init(
              red: 230,
              green: 154,
              blue: 154
            )
        )
      }.padding(.leading, 10)
    }
    .frame(height: 100)
  }
}

#if DEBUG
struct AddWorkoutRow_Previews: PreviewProvider {
  static var previews: some View {
    AddWorkoutRow()
  }
}
#endif

