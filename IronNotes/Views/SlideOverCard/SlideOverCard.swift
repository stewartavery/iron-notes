//
//  SlideOverCard.swift
//  IronNotes
//
//  Created by Stewart Avery on 8/22/20.
//  Copyright © 2020 Stewart Avery. All rights reserved.
//

import SwiftUI

let minCardHeight: CGFloat = 75

struct SlideOverCard<Content: View> : View {
  @Environment(\.colorScheme) var colorScheme: ColorScheme
  @GestureState private var dragState = DragState.inactive
  @StateObject var cardDetails = CardDetails()
  
  var content: () -> Content
  
  var body: some View {
    GeometryReader { geometry in
      VStack {
        Handle()
        content().environmentObject(cardDetails)
      }
      .background(colorScheme == .light ? Color.white : Color(UIColor.systemGray6))
      .cornerRadius(10.0)
      .shadow(color: Color(.sRGBLinear, white: 0, opacity: 0.13), radius: 10.0)
      .offset(y: getCardHeight(geometryHeight: geometry.size.height, cardPosition: cardDetails.position) + getThrottledOffset())
      .animation(self.dragState.isDragging ? nil : .interpolatingSpring(stiffness: 300.0, damping: 30.0, initialVelocity: 10.0))
      .gesture(
        DragGesture(minimumDistance: 50.0)
          .updating($dragState) { drag, state, transaction in
            if drag.predictedEndLocation.y - drag.location.y > 0 {
              state = .down(translation: drag.translation)
            } else {
              state = .up(translation: drag.translation)
            }
          }
          .onEnded { drag in
            onDragEnded(drag: drag, geometryHeight: geometry.size.height)
          }
      )
    }.frame(maxHeight: .infinity)  }
  
  private func handleParentScroll(_ scrollDirection: ScrollDirection) {
    switch (scrollDirection, cardDetails.position) {
    case (.down(_), .middle),
         (.down(_), .top):
      cardDetails.position = .bottom
    default:
      break
    }
  }
  
  private func getCardHeight(geometryHeight: CGFloat, cardPosition: CardPosition) -> CGFloat {
    switch cardPosition {
    case .top:
      return 50
    case .middle:
      return geometryHeight / 2
    case .bottom:
      return geometryHeight - minCardHeight
    }
  }
  
  private func getThrottledOffset() -> CGFloat {
    // TODO: fix bug with dragging up at the top
    return (dragState.translation.height * 0.5)
  }
  
  
  private func onDragEnded(drag: DragGesture.Value, geometryHeight: CGFloat) {
    let middleHeight = getCardHeight(geometryHeight: geometryHeight, cardPosition: CardPosition.middle)
    let currentHeight = getCardHeight(geometryHeight: geometryHeight, cardPosition: cardDetails.position)
    
    let verticalDirection = drag.predictedEndLocation.y - drag.location.y
    let cardTopEdgeLocation = currentHeight + drag.translation.height
    
    let positionAbove: CardPosition
    let positionBelow: CardPosition
    let closestPosition: CardPosition
    
    // TODO: find a better way to handle coordinate system
    if cardTopEdgeLocation <= middleHeight {
      positionAbove = .top
      positionBelow = .middle
    } else {
      positionAbove = .middle
      positionBelow = .bottom
    }
    
    if (cardTopEdgeLocation - getCardHeight(geometryHeight: geometryHeight, cardPosition: positionAbove)) < (getCardHeight(geometryHeight: geometryHeight, cardPosition: positionBelow) - cardTopEdgeLocation) {
      closestPosition = positionAbove
    } else {
      closestPosition = positionBelow
    }
    
    if verticalDirection > 100 {
      cardDetails.position = positionBelow
    } else if verticalDirection < -100 {
      cardDetails.position = positionAbove
    } else {
      cardDetails.position = closestPosition
    }
  }
}


enum DragState {
  case inactive
  case up(translation: CGSize)
  case down(translation: CGSize)
  case left(translation: CGSize)
  case right(translation: CGSize)
  
  var translation: CGSize {
    switch self {
    case .inactive:
      return .zero
    case .up(let translation), .down(let translation), .left(let translation), .right(let translation):
      return translation
    }
  }
  
  var isDragging: Bool {
    switch self {
    case .inactive:
      return false
    default:
      return true
    }
  }
}
