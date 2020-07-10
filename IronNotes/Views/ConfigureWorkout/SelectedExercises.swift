//
//  SelectedExercises.swift
//  IronNotes
//
//  Created by Stewart Avery on 7/9/20.
//  Copyright © 2020 Stewart Avery. All rights reserved.
//

import Foundation

class SelectedExercises: ObservableObject {
  @Published var exercises = [ExerciseTemplate]()
}
