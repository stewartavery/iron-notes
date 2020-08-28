//
//  KeyboardMonitor.swift
//  IronNotes
//
//  Created by Stewart Avery on 8/21/20.
//  Copyright © 2020 Stewart Avery. All rights reserved.
//

import Foundation
import Combine
import UIKit

enum KeyboardStatus {
  case presented(CGFloat)
  case hidden
  
  var isPresented: Bool {
    switch self {
    case .hidden:
      return false
    case .presented(_):
      return true
    }
  }
}

class KeyboardMonitor: ObservableObject, Equatable {
  
  static func == (lhs: KeyboardMonitor, rhs: KeyboardMonitor) -> Bool {
    switch (lhs.keyboardStatus, rhs.keyboardStatus) {
    case (.hidden, .hidden):
      return true
    case (let .presented(height1), let .presented(height2)):
      return height1 == height2
    default:
      return false
    }
  }
  
  @Published var keyboardStatus: KeyboardStatus = .hidden
  private var cancellable: AnyCancellable?
  
  init() {
    self.cancellable = Publishers.keyboardHeight
      .map { $0 == 0.0 ? .hidden : .presented($0) }
      .assign(to: \.keyboardStatus, on: self)
  }
}
