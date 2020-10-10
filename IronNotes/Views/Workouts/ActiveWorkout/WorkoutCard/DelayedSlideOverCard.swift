//
//  DelayedSlideOverCard.swift
//  IronNotes
//
//  Created by Stewart Avery on 8/23/20.
//  Copyright © 2020 Stewart Avery. All rights reserved.
//

import SwiftUI

struct DelayedSlideOverCard: View {
  @Environment(\.scenePhase) private var scenePhase
  @EnvironmentObject var keyboardMonitor: KeyboardMonitor
  
  @State var isViewHidden = true
  @State var delay = 0.0
  
  @Binding var workoutSheet: WorkoutSheet?
    
  var body: some View {
    switch (keyboardMonitor.keyboardStatus, isViewHidden)  {
    case (.hidden, true):
      Text("").onAppear {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
          self.isViewHidden = false
          self.delay = 0.0
        }
      }
    case (.hidden, false):
      SlideOverCard {
        WorkoutCard(workoutSheet: $workoutSheet)
      }
      
      .transition(.move(edge: .bottom))
      .animation(.easeIn)
    case (.presented(_), _):
      Text("").onAppear {
        self.isViewHidden = true
        self.delay = 0.1
      }
    }
    
  }
}
