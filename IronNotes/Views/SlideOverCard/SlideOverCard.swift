//
//  SlideOverCard.swift
//  IronNotes
//
//  Created by Stewart Avery on 8/22/20.
//  Copyright © 2020 Stewart Avery. All rights reserved.
//

import SwiftUI

let minCardHeight: CGFloat = 100

let minimumDragDistance: CGFloat = 20

struct SlideOverCard<Content: View> : View {
  @Environment(\.colorScheme) var colorScheme: ColorScheme
  @GestureState private var dragState = DragState.inactive
  
  @EnvironmentObject var cardDetails: CardDetails
  
  var content: () -> Content
  
  var body: some View {
    GeometryReader { geometry in
      VStack {
        Handle()
        content().environmentObject(cardDetails)
      }
      .background(Color(UIColor.systemGray6))
      .cornerRadius(10.0)
      .shadow(color: Color(.sRGBLinear, white: 0, opacity: 0.13), radius: 10.0)
      .offset(y: getThrottledOffset(geometryHeight: geometry.size.height))
      .animation(self.dragState.isDragging ? nil : .interpolatingSpring(stiffness: 300.0, damping: 30.0, initialVelocity: 10.0))
      .highPriorityGesture(
        DragGesture(minimumDistance: minimumDragDistance)
          .updating($dragState) { drag, state, transaction in
            
            // Set initial direcion, then maintain that direction
            state = {
              switch(state) {
              case .draggingDown(_):
                return .draggingDown(translation: drag.translation)
              case .draggingUp(_):
                return .draggingUp(translation: drag.translation)
              case .inactive where drag.predictedEndLocation.y - drag.location.y > 0:
                return .draggingDown(translation: drag.translation)
              case .inactive:
                return .draggingUp(translation: drag.translation)
              }
            }()
                 
            let bottomOrigin = getCardHeight(geometryHeight: geometry.size.height, cardPosition: CardPosition.bottom)
            let yPos = getThrottledOffset(geometryHeight: geometry.size.height)
            
            cardDetails.opacity = min(((bottomOrigin - yPos) / 40), 1.0)
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
      return geometryHeight * 0.6
    case .middle:
      return geometryHeight * 0.6
    case .bottom:
      return geometryHeight - minCardHeight
    }
  }
  
  private func getThrottledOffset(geometryHeight: CGFloat) -> CGFloat {
    let currentHeight = getCardHeight(geometryHeight: geometryHeight, cardPosition: cardDetails.position)
    let maxHeight = getCardHeight(geometryHeight: geometryHeight, cardPosition: CardPosition.middle)
    let minHeight = getCardHeight(geometryHeight: geometryHeight, cardPosition: CardPosition.bottom)

    let offset = dragState.translationHeightWithAdjustment
    let throttledOffset = offset * 0.2

    if (currentHeight + offset - throttledOffset) < maxHeight {
      return maxHeight + throttledOffset
    }
    
    if (currentHeight + offset - throttledOffset) > minHeight {
      return minHeight + throttledOffset
    }
    
    return currentHeight + offset
  }
  
  
  private func onDragEnded(drag: DragGesture.Value, geometryHeight: CGFloat) {
    let middleHeight = getCardHeight(geometryHeight: geometryHeight, cardPosition: CardPosition.middle)
    let currentHeight = getCardHeight(geometryHeight: geometryHeight, cardPosition: cardDetails.position)
    let bottomHeight = getCardHeight(geometryHeight: geometryHeight, cardPosition: CardPosition.bottom)
    
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
    
    let currentCardHeight = getCardHeight(geometryHeight: geometryHeight, cardPosition: cardDetails.position)
    
    cardDetails.opacity = min(((bottomHeight - currentCardHeight) / 40), 1.0)
  }
}


enum DragState {
  case inactive
  case draggingUp(translation: CGSize)
  case draggingDown(translation: CGSize)
  
  var translation: CGSize {
    switch self {
    case .inactive:
      return .zero
    case .draggingUp(let translation), .draggingDown(let translation):
      return translation
    }
  }
  
  var translationHeightWithAdjustment: CGFloat {
    switch self {
    case .inactive:
      return .zero
    case .draggingUp(let translation):
      return translation.height + 20
    case .draggingDown(let translation):
      return translation.height - 20
    }
  }
  
  var isDragging: Bool {
    switch self {
    case .inactive:
      return false
    case .draggingUp, .draggingDown:
      return true
    }
  }
}
