//
//  KeyboardAdaptive.swift
//  IronNotes
//
//  Created by Stewart Avery on 8/14/20.
//  Copyright © 2020 Stewart Avery. All rights reserved.
//


import SwiftUI
import Combine

/// Note that the `KeyboardAdaptive` modifier wraps your view in a `GeometryReader`,
/// which attempts to fill all the available space, potentially increasing content view size.
struct KeyboardAdaptive: ViewModifier {
  @State private var bottomPadding: CGFloat = 0
  
  func body(content: Content) -> some View {
    content
      .padding(.bottom, self.bottomPadding)
      .onReceive(Publishers.keyboardHeight) { keyboardHeight in
        self.bottomPadding = keyboardHeight
      }
      .animation(.easeOut(duration: 0.16))
    
  }
}

extension View {
  func keyboardAdaptive() -> some View {
    ModifiedContent(content: self, modifier: KeyboardAdaptive())
  }
}
