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
  case running(workout: Workout, startTime: Date)
  case stopped
}

class Model: ObservableObject, Identifiable {
    @Published var offset: CGFloat = 0

    let id = UUID()

    private var tickets: [AnyCancellable] = []
  

    init() {
        Timer.publish(every: 0.5, on: RunLoop.main, in: .common)
            .autoconnect()
            .map { _ in CGFloat.random(in: 0...300) }
            .sink { [weak self] in self?.offset = $0 }
            .store(in: &tickets)
    }
}

class StopwatchManager: ObservableObject {
  
  @Published var mode: StopWatchMode = .stopped
  @Published var secondsElapsed: Double = 0
  
  private var cancellable: AnyCancellable?

  let formatter = DateComponentsFormatter()
    
  func start(_ workout: Workout) {
    self.mode = .running(workout: workout, startTime: Date())
    
    self.cancellable = Timer.publish(every: 1, on: .main, in: .common)
        .autoconnect()
        .sink { _ in self.secondsElapsed += 1 }
  }
  
  func stop() {
    self.cancellable?.cancel()
    self.secondsElapsed = 0
    self.mode = .stopped
  }
  
  func resumeFromBackground() {
    switch mode {
    case .running(_, let startTime):
      self.secondsElapsed = Date().timeIntervalSince(startTime)
      break
    default:
      break
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
