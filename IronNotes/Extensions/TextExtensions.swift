//
//  TextExtensions.swift
//  IronNotes
//
//  Created by Stewart Avery on 10/13/20.
//  Copyright © 2020 Stewart Avery. All rights reserved.
//

import SwiftUI

extension Text {
  func workoutCardButtonModifier(background: Color) -> some View {
    self
      .fontWeight(.bold)
      .frame(maxWidth: .infinity)
      .padding()
      .background(background)
      .font(.headline)
      .cornerRadius(10)
      .foregroundColor(Color.white)
  }
}



