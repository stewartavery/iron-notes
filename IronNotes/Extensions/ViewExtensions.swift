//
//  ViewExtensions.swift
//  IronNotes
//
//  Created by Stewart Avery on 9/17/20.
//  Copyright © 2020 Stewart Avery. All rights reserved.
//

import SwiftUI

extension View {
  func hideKeyboard() {
    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
  }
}
