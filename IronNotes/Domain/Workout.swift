//
//  Workout.swift
//  IronNotes
//
//  Created by Stewart Avery on 7/25/19.
//  Copyright © 2019 Stewart Avery. All rights reserved.
//

import SwiftUI

struct Workout: Identifiable, Codable {
  var id: Int
  var name: String
  var desc: String
  var iconName: String /* this needs improvement */
  var lastWorkout: Date
  
  func dayDifference(from date : Date) -> String {
    let calendar = Calendar.current
    if calendar.isDateInYesterday(date) { return "Yesterday" }
    else if calendar.isDateInToday(date) { return "Today" }
    else if calendar.isDateInTomorrow(date) { return "Tomorrow" }
    else {
      let startOfNow = calendar.startOfDay(for: Date())
      let startOfTimeStamp = calendar.startOfDay(for: date)
      let components = calendar.dateComponents([.day], from: startOfNow, to: startOfTimeStamp)
      let day = components.day!
      if day < 1 { return "\(-day) days ago" }
      else { return "In \(day) days" }
    }
  }
}
