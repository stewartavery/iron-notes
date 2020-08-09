//
//  InlineAccessoryView.swift
//  IronNotes
//
//  Created by Stewart Avery on 8/8/20.
//  Copyright © 2020 Stewart Avery. All rights reserved.
//

import SwiftUI

struct InlineAccessoryView: View {
  @Environment(\.colorScheme) var colorScheme: ColorScheme
  
  var textFields = [UITextField]() {
    didSet {
      textFields.sort(by: {$0.tag < $1.tag})
    }
  }
  
  var currentTextFieldTag = 0
  
  var body: some View {
    VStack(alignment: .leading, spacing: 0.0) {
      Divider()
      HStack(alignment: .center) {
        Spacer()
        Button {
          previousTextField()
        } label: {
          Image(systemName: "arrow.left")
            .resizable()
            .scaledToFit()
            .frame(width: 20, height: 20)
            .foregroundColor(currentIndex() == 0 ? Color.gray : nil)
        }
        .disabled(currentIndex() == 0)
        .padding()
        
        Spacer()
        
        Button {
          nextTextField()
        } label: {
          Image(systemName: "arrow.right")
            .resizable()
            .scaledToFit()
            .frame(width: 20, height: 20)
            .foregroundColor(currentIndex() == textFields.count - 1 ? Color.gray : nil)
        }
        .disabled(currentIndex() == textFields.count - 1)
        .padding()
        
        Spacer()
        
        Button {
          dismissCurrentTextField()
        } label: {
          Image(systemName: "checkmark.shield")
            .resizable()
            .scaledToFit()
            .frame(width: 20, height: 20)
        }
        .padding()
        
        Spacer()
          
      }
      .frame(height: 45)
      .background(colorScheme == .light ? Color.white : Color(UIColor.systemGray6))
      .accentColor(colorScheme == .light ? Color.black : Color.white)
    }
  }
  
  func currentIndex() -> Int? {
    self.textFields.firstIndex(where: {$0.tag == self.currentTextFieldTag})
  }
  
  func nextTextField() {
    if let currentIndex = currentIndex(), currentIndex + 1 < textFields.count {
      textFields[currentIndex + 1].becomeFirstResponder()
    }
    else {
      dismissCurrentTextField()
    }
  }
  
  func previousTextField() {
    if let currentIndex = currentIndex(), currentIndex > 0 {
      textFields[currentIndex - 1].becomeFirstResponder()
    }
  }
  
  func dismissCurrentTextField() {
    if let currentIndex = currentIndex() {
      textFields[currentIndex].resignFirstResponder()
    }
  }
}

#if DEBUG
struct InlineAccessoryView_Previews: PreviewProvider {
  static var previews: some View {
    InlineAccessoryView()
      .environment(\.colorScheme, .dark)
  }
}
#endif
