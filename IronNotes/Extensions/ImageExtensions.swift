//
//  ImagExtensions.swift
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
      .frame(width: 40, height: 40)
      .padding()
  }
  
  func rowIconCircle() -> some View {
    self
      .resizable()
      .scaledToFit()
      .frame(width: 22, height: 22)
      .padding(.trailing, 10)
  }
}
