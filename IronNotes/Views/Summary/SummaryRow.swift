//
//  SummaryRow.swift
//  IronNotes
//
//  Created by Stewart Avery on 11/25/20.
//  Copyright © 2020 Stewart Avery. All rights reserved.
//

import SwiftUI

struct ColoredCapsule: View {
  private var color: Color
  
  init(_ color: Color) {
    self.color = color
  }
  
  var body: some View {
    ContainerRelativeShape()
      .fill(color)
      .frame(width: 10)
  }
}

struct SummaryRow<Content: View> : View {
  var title: String
  var description: String
  var color: Color
  var content: () -> Content
  
  init(title: String, description: String, color: Color, content: @escaping () -> Content) {
    self.title = title
    self.description = description
    self.color = color
    self.content = content
  }
  
  var body: some View {
    NavigationLink(destination: content()) {
      GroupBox(label: ColoredCapsule(color)) {
        VStack(alignment: .leading) {
          Text(title)
            .font(.headline)
            .foregroundColor(Color.primary)
          
          Text(description)
            .foregroundColor(.gray)
        }
      }.groupBoxStyle(CardGroupBoxStyle())
    }
  }
}

struct SummaryRow_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      ZStack {
        Color(.systemGroupedBackground)
          .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        
        ScrollView {
          SummaryRow(title: "Some title", description: "Some text", color: .red) {
            Text("hey")
          }.padding()
        }
      }
      ZStack {
        Color(.systemGroupedBackground)
          .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        
        ScrollView {
          SummaryRow(title: "Some title", description: "Some text", color: .red) {
            Text("Yo")
          }.padding()
        }
        
      }.environment(\.colorScheme, .dark)
    }
    
  }
}
