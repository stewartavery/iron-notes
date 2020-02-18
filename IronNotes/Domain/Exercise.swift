//
//  Exercise.swift
//  IronNotes
//
//  Created by Stewart Avery on 2/16/20.
//  Copyright © 2020 Stewart Avery. All rights reserved.
//

import SwiftUI

struct Exercise: Identifiable, Codable {
  var id: Int
  var meta: ExerciseMeta
  var sets: [ExerciseSet]
}
