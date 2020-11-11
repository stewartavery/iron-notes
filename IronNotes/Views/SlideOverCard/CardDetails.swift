//
//  CardDetails.swift
//  IronNotes
//
//  Created by Stewart Avery on 9/7/20.
//  Copyright © 2020 Stewart Avery. All rights reserved.
//

import Foundation
import UIKit

enum CardPosition: CGFloat {
  case top
  case middle
  case bottom
}

class CardDetails: ObservableObject {
  @Published var position: CardPosition {
    didSet {
      if position == .bottom {
        self.opacity = 0
      }
    }
  }
  
  @Published var opacity: CGFloat = 0
  
  init(position: CardPosition = .bottom, opacity: CGFloat = 0.0) {
    self.position = position
    self.opacity = opacity
  }
}
