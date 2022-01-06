//
//  ColorExtensions.swift
//  IronNotes
//
//  Created by Stewart Avery on 12/9/20.
//  Copyright © 2020 Stewart Avery. All rights reserved.
//

import SwiftUI

extension Color {
  static func color(data:Data) -> Color? {
    return try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? Color
  }
  
  func encode() -> Data? {
    return try? NSKeyedArchiver.archivedData(withRootObject: self, requiringSecureCoding: false)
  }
}
