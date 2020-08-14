//
//  InlineAccessoryView.swift
//  IronNotes
//
//  Created by Stewart Avery on 8/8/20.
//  Copyright © 2020 Stewart Avery. All rights reserved.
//

import SwiftUI

enum ExpandedBar {
  case none
  case weights
  case reps
}

struct InlineAccessoryView: View {
  @Environment(\.colorScheme) var colorScheme: ColorScheme
  @State var expandedBar: ExpandedBar = .none
  
  var textFields = [UITextField]() {
    didSet {
      textFields.sort(by: {$0.tag < $1.tag})
    }
  }
  
  var currentTextFieldTag = 0
  
  var body: some View {
    VStack(alignment: .leading, spacing: 0.0) {
      Divider()
      
      switch expandedBar {
      case .none:
        EmptyView()
      case .weights:
          VStack {
            
            Spacer()
            HStack {
              
              Spacer()
              
              Button {
                print("45")
              } label: {
                Text("+ 45")
              }
              
              Spacer()
              
              Button {
                print("35")
              } label: {
                Text("+ 35")
              }
              
              Spacer()
              
              Button {
                print("25")
              } label: {
                Text("+ 25")
              }
              
              Spacer()
            }
            
            Spacer()
            
            HStack {
              
              Spacer()
              
              Button {
                print("10")
              } label: {
                Text("+ 10")
              }
              
              Spacer()
              
              
              Button {
                print("5")
              } label: {
                Text("+ 5")
              }
              
              Spacer()
              
              
              Button {
                print("2.5")
              } label: {
                Text("+ 2.5")
              }
              
              Spacer()
               

            }
            Spacer()
        }
        .animation(.easeInOut(duration: 0.3))
        .frame(height: 80)
        .transition(.move(edge: .bottom))
      case .reps:
        EmptyView()
      }
      GeometryReader { geometry in

        HStack(alignment: .center) {
          Button {
            previousTextField()
          } label: {
            Image(systemName: "arrow.left")
              .resizable()
              .scaledToFit()
              .frame(width: 20, height: 20)
              .frame(width: geometry.size.width * 0.25, height: geometry.size.height)
              .foregroundColor(currentIndex() == 0 ? Color.gray : nil)
          }
          .disabled(currentIndex() == 0)
          
          Button {
            nextTextField()
          } label: {
            Image(systemName: "arrow.right")
              .resizable()
              .scaledToFit()
              .frame(width: 20, height: 20)
              .frame(width: geometry.size.width * 0.25, height: geometry.size.height)
              .foregroundColor(currentIndex() == textFields.count - 1 ? Color.gray : nil)
          }
          
          Button {
            withAnimation(.easeInOut(duration: 0.3)) {
              expandedBar = expandedBar == .none ? .weights : .none
            }
          } label: {
            Image(systemName: "plus.slash.minus")
              .resizable()
              .scaledToFit()
              .frame(width: 20, height: 20)
              .frame(width: geometry.size.width * 0.25, height: geometry.size.height)
          }
          
          Button {
            dismissCurrentTextField()
          } label: {
            Image(systemName: "keyboard.chevron.compact.down")
              .resizable()
              .scaledToFit()
              .frame(width: 20, height: 20)
              .frame(width: geometry.size.width * 0.25, height: geometry.size.height)
          }
            
        }
      }
      .frame(height: 45)
      .accentColor(colorScheme == .light ? Color.black : Color.white)
    }
    .background(colorScheme == .light ? Color.white : Color(UIColor.systemGray6))
    
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
