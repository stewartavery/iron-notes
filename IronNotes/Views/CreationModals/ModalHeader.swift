//
//  ModalHeader.swift
//  IronNotes
//
//  Created by Stewart Avery on 3/25/20.
//  Copyright © 2020 Stewart Avery. All rights reserved.
//

import SwiftUI


struct ModalHeader: View {
  @Binding var isPresented: Bool
  var title: String
  
  var body: some View {
    VStack {
      HStack {
        Button(action: {self.isPresented.toggle()})  {
          Text("Cancel")
        }
        Spacer()
        Text(self.title)
          .font(.headline)
        Spacer()
        Button(action: {self.isPresented.toggle()})  {
          Text("Done")
            .foregroundColor(Color.blue)
            .fontWeight(.bold)
        }
      }
      Spacer()
    }.padding(.top, 20)
      .padding(.leading, 20)
      .padding(.trailing, 20)
      .frame(height: 60)
  }
}

struct ModalHeader_Previews: PreviewProvider {
  @State static var isModalPresented = true
  
  static var previews: some View {
    ModalHeader(isPresented: $isModalPresented, title: "New Test Modal")
  }
}
