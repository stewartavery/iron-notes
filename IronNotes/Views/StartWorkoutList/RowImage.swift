//
//  RowImage.swift
//  IronNotes
//
//  Created by Stewart Avery on 8/9/19.
//  Copyright © 2019 Stewart Avery. All rights reserved.
//

import SwiftUI

struct RowImage: View {
  var iconName: String
  
  var body: some View {
    Image(iconName)
      .workoutImageModifier()
  }
}
#if DEBUG
struct RowImage_Previews: PreviewProvider {
  static var previews: some View {
    RowImage(iconName: "dumbbell")
  }
}
#endif
