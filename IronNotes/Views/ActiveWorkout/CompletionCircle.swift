//
//  CompletionCircle.swift
//  IronNotes
//
//  Created by Stewart Avery on 6/6/20.
//  Copyright © 2020 Stewart Avery. All rights reserved.
//

import SwiftUI

struct CompletionCircle: View {
  
  @State private var isCompleted: Bool = false
  
  var body: some View {
    Button(action: toggleIsCompleted) {
      if isCompleted {
        Image(systemName: "largecircle.fill.circle")
      } else {
        Image(systemName: "circle")
          .foregroundColor(Color.gray)
      }
    }
  }
  
  func toggleIsCompleted() {
    isCompleted.toggle()
  }
}

struct CompletionCircle_Previews: PreviewProvider {
  static var previews: some View {
    CompletionCircle()
  }
}
