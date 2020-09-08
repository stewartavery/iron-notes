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
  @Published var position: CardPosition = .bottom
}
