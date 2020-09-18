//
//  StopwatchManager.swift
//  IronNotes
//
//  Created by Stewart Avery on 8/6/20.
//  Copyright © 2020 Stewart Avery. All rights reserved.
//

import SwiftUI
import Combine

enum StopWatchMode {
  case running, stopped
}

class StopwatchManager: ObservableObject {
  
  @Published var mode: StopWatchMode = .stopped
  @Published var secondsElapsed: Double = 0
  
  private var cancellable: AnyCancellable?

  let formatter = DateComponentsFormatter()
    
  func start() {
    self.mode = .running
    
    self.cancellable = Timer.publish(every: 1, on: .main, in: .common)
        .autoconnect()
        .sink { _ in self.secondsElapsed += 1 }
  }
  
  func stop() {
    self.cancellable?.cancel()
    self.secondsElapsed = 0
    self.mode = .stopped
  }
  
  func resumeFromBackground(startTime: Date) {
    self.secondsElapsed = Date().timeIntervalSince(startTime)
    self.start()
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
