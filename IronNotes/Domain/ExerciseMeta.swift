//
//  ExerciseMeta.swift
//  IronNotes
//
//  Created by Stewart Avery on 2/16/20.
//  Copyright © 2020 Stewart Avery. All rights reserved.
//

import SwiftUI

struct ExerciseMeta: Identifiable, Codable {
  var id: Int
  var name: String
  var description: String
  var exerciseType: ExerciseType
}
