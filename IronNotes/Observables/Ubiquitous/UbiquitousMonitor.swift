//
//  UbiquitousMonitor.swift
//  IronNotes
//
//  Created by Stewart Avery on 10/27/20.
//  Copyright © 2020 Stewart Avery. All rights reserved.
//


import SwiftUI
import Combine

enum RecordKey: String {
  case didSyncDefaultData
}

class UbiquitousMonitor: ObservableObject {
  private let key: RecordKey
  
  @Published var value: Bool = false {
    didSet {
      let kvStorage = NSUbiquitousKeyValueStore()
      kvStorage.set(value, forKey: key.rawValue)
      kvStorage.synchronize()
    }
  }
  
  @Published var hasUnhandledValue: Bool = false
  
  init(key: RecordKey) {
    self.key = key
    self.readControl()
    
    let publisher = NotificationCenter.Publisher(center: .default, name: NSUbiquitousKeyValueStore.didChangeExternallyNotification)
      .receive(on: RunLoop.main)
    
    let subscriber = Subscribers.Sink<Notification, Never>(receiveCompletion: {_ in }, receiveValue: {_ in
      self.readControl()
    })
    
    publisher.subscribe(subscriber)
  }
  
  func readControl() {
    let kvStorage = NSUbiquitousKeyValueStore()
    let sharedValue = kvStorage.bool(forKey: key.rawValue)
    
    if value != sharedValue {
      hasUnhandledValue = true
    }
    
    value = sharedValue
    
  }
}

