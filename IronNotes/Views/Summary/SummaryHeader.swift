//
//  SummaryHeader.swift
//  IronNotes
//
//  Created by Stewart Avery on 11/18/20.
//  Copyright © 2020 Stewart Avery. All rights reserved.
//

import SwiftUI

struct SummaryHeader<Content: View> : View {
  var title: String
  var content: () -> Content
  
  init(_ title: String, content: @escaping () -> Content) {
    self.title = title
    self.content = content
  }
  
  var body: some View {
    HStack {
      Text(title)
      Spacer()
      NavigationLink(destination: content()) {
        Text("View All")
      }
    }
  }
}

struct SummaryHeader_Previews: PreviewProvider {
  static var previews: some View {
    SummaryHeader("Workouts") {
      Text("Hey")
    }
  }
}
