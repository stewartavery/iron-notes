//
//  WorkoutImageModifier.swift
//  IronNotes
//
//  Created by Stewart Avery on 6/2/20.
//  Copyright © 2020 Stewart Avery. All rights reserved.
//

import SwiftUI

extension Image {
  func workoutImageModifier() -> some View {
    self
      .resizable()
      .frame(width: 65, height: 65)
      .padding()
      .clipShape(RoundedRectangle(cornerRadius: 5))
      .overlay(
        RoundedRectangle(cornerRadius: 5)
          .stroke(lineWidth: 0.3)
          .foregroundColor(Color.gray)
    )
  }
}
