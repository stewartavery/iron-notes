//
//  TextFieldAccessoryView.swift
//  IronNotes
//
//  Created by Stewart Avery on 7/31/20.
//  Copyright © 2020 Stewart Avery. All rights reserved.
//

import SwiftUI

struct TextFieldAccessoryView: View {
  
  var textFields = [UITextField]() {
    // Order our textfields in the array by their tag
    didSet {
      textFields.sort(by: {$0.tag < $1.tag})
    }
  }
  
  var currentTextFieldTag = 0
  
  var body: some View {
    HStack {
      Button(action: previousTextField, label: {
        Image(systemName: "chevron.up")
      })
      .disabled(currentIndex() == 0)
      .padding()
      Button(action: nextTextField, label: {
        Image(systemName: "chevron.down")
      })
      .disabled(currentIndex() == textFields.count - 1)
      Spacer()
      Button(action: dismissCurrentTextField, label: {
        Text("Done")
      })
      .padding()
    }.accentColor(.blue)
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

struct TextFieldAccessoryView_Previews: PreviewProvider {
  static var previews: some View {
    TextFieldAccessoryView()
  }
}
