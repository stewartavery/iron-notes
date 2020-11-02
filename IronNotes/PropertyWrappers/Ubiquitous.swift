//
//  Ubiquitous.swift
//  IronNotes
//
//  Created by Stewart Avery on 10/27/20.
//  Copyright © 2020 Stewart Avery. All rights reserved.
//

import SwiftUI

@propertyWrapper
struct Ubiquitous<T> {
  private var key: String
  private var defaultValue: T
  private var store: NSUbiquitousKeyValueStore
  
  init(key: String, defaultValue: T, store: NSUbiquitousKeyValueStore = .default) {
    self.key = key
    self.defaultValue = defaultValue
    self.store = store
  }
  
  var wrappedValue: T {
    get {
      return store.object(forKey: key) as? T ?? defaultValue
    }
    set {
      store.set(newValue, forKey: key)
    }
  }
}
