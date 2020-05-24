//
//  Workout+CoreDataClass.swift
//  IronNotes
//
//  Created by Stewart Avery on 5/24/20.
//  Copyright © 2020 Stewart Avery. All rights reserved.
//
//

import Foundation
import CoreData

public class Workout: Workout {
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
