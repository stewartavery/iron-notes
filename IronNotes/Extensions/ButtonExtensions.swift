//
//  ButtonExtensions.swift
//  IronNotes
//
//  Created by Stewart Avery on 10/13/20.
//  Copyright © 2020 Stewart Avery. All rights reserved.
//

import SwiftUI

struct WorkoutStartStyle: ButtonStyle {
  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .font(Font.headline.bold())
      .frame(maxWidth: .infinity)
      .padding()
      .foregroundColor(Color.white)
      .background(
        Color.orange.opacity(configuration.isPressed ? 0.5 : 1)
      )
      .cornerRadius(10)
      .frame(width: 75)
  }
}

struct WorkoutStopStyle: ButtonStyle {
  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .font(Font.headline.bold())
      .frame(maxWidth: .infinity)
      .padding()
      .foregroundColor(Color.white)
      .background(
        Color.red.opacity(configuration.isPressed ? 0.5 : 1)
      )
      .cornerRadius(10)
      .frame(width: 75)
  }
}

struct WorkoutActionStyle: ButtonStyle {
  var colorScheme: ColorScheme
  
  func makeBody(configuration: Configuration) -> some View {
    let primaryColor = colorScheme == .light ? Color(UIColor.systemGray6) : Color(UIColor.systemGray4)
    let pressedColor = colorScheme == .light ? Color(UIColor.systemGray2) : Color(UIColor.systemGray2)
    let fontColor = colorScheme == .light ? Color.black : Color.white
    
    return configuration.label
      .padding()
      .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
      .foregroundColor(fontColor)
      .background(
        RoundedRectangle(cornerRadius: 10)
          .fill(configuration.isPressed ? pressedColor : primaryColor)
      )
  }
}
