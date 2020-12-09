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
        .font(.headline)
      Spacer()
      NavigationLink(destination: content()) {
        Text("View All")
      }.frame(height: 25)
    }.padding(.top)
  }
}

struct SummaryHeader_Previews: PreviewProvider {
  static var previews: some View {
    VStack {
      Spacer()
      SummaryHeader("Workouts") {
        Text("Hey")
      }.background(Color.white)
      Spacer()
    }.background(Color.gray)
  }
}
