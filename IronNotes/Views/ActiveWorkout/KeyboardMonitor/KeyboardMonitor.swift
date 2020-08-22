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

class KeyboardMonitor: ObservableObject {
  @Published var keyboardStatus: KeyboardStatus = .hidden
  private var cancellable: AnyCancellable?
  
  enum KeyboardStatus {
    case presented(CGFloat)
    case hidden
  }
  
  init() {
    self.cancellable = Publishers.keyboardHeight
      .map { $0 == 0.0 ? .hidden : .presented($0) }
      .assign(to: \.keyboardStatus, on: self)
  }
}
