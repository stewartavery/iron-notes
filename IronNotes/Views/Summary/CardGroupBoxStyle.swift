//
//  CardGroupBoxStyle.swift
//  IronNotes
//
//  Created by Stewart Avery on 11/25/20.
//  Copyright © 2020 Stewart Avery. All rights reserved.
//

import SwiftUI

struct CardGroupBoxStyle: GroupBoxStyle {
  func makeBody(configuration: Configuration) -> some View {
    HStack {
      configuration.label
      
      configuration.content
        .padding()
      
      Spacer()
      
      Image(systemName: "chevron.forward")
        .resizable()
        .scaledToFit()
        .frame(width: 12, height: 12)
        .foregroundColor(Color.gray)
        .padding()
    }
    .background(Color(.secondarySystemGroupedBackground))
    .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
  }
}
