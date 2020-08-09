//
//  InlineAccessoryViewController.swift
//  IronNotes
//
//  Created by Stewart Avery on 8/8/20.
//  Copyright © 2020 Stewart Avery. All rights reserved.
//

import SwiftUI
import UIKit

class InlineAccessoryViewController: UIHostingController<InlineAccessoryView> {
  
  convenience init () {
    self.init(rootView: InlineAccessoryView())
  }
  
  private override init(rootView: InlineAccessoryView) {
    super.init(rootView: rootView)
    view.frame = CGRect(x: 0, y: 0, width: 0 , height: 45)
  }
  
  @objc required dynamic init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func addTextField(_ textField: UITextField) {
    rootView.textFields.append(textField)
  }
  
  func removeTextField(_ textField: UITextField) {
    rootView.textFields.removeAll(where: {$0 == textField})
  }
  
  func setCurrentTextFieldTag(_ tag: Int) {
    rootView.currentTextFieldTag = tag
  }
  
  func advanceToNextTextField() {
    rootView.nextTextField()
  }
}
