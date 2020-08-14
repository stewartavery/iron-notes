//
//  RowImage.swift
//  IronNotes
//
//  Created by Stewart Avery on 8/9/19.
//  Copyright © 2019 Stewart Avery. All rights reserved.
//

import SwiftUI

struct RowImage: View {
  @Environment(\.colorScheme) var colorScheme: ColorScheme
  var iconName: String
  
  var body: some View {
    ZStack {
      Image(iconName)
        .workoutImageModifier()
      if(colorScheme == .dark) {
        Color.gray.blendMode(.sourceAtop)
          .frame(width: 65)
          .padding(.bottom, 10)
      }
     
    }
  }
}

#if DEBUG
struct RowImage_Previews: PreviewProvider {
  static var previews: some View {
    RowImage(iconName: "dumbbell")
  }
}
#endif
