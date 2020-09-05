//
//  StopwatchManager.swift
//  IronNotes
//
//  Created by Stewart Avery on 8/6/20.
//  Copyright © 2020 Stewart Avery. All rights reserved.
//

import SwiftUI

enum StopWatchMode {
  case running
  case stopped
  case paused
}

class StopwatchManager: ObservableObject {
  
  @Published var mode: StopWatchMode = .stopped
  @Published var secondsElapsed: Double = 0
  
  let formatter = DateComponentsFormatter()
  
  var timer = Timer()
  
  func stop() {
    timer.invalidate()
    secondsElapsed = 0
    mode = .stopped
  }
  
  func pause() {
    timer.invalidate()
    mode = .paused
  }
  
  func start() {
    mode = .running
    timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
      self.secondsElapsed += 1
    }
  }
}

extension Double {
  func asString(style: DateComponentsFormatter.UnitsStyle) -> String {
    let formatter = DateComponentsFormatter()
    formatter.allowedUnits = [.hour, .minute, .second, .nanosecond]
    formatter.unitsStyle = style
    formatter.zeroFormattingBehavior = .pad
    guard let formattedString = formatter.string(from: self) else { return "" }
    return formattedString
  }
}