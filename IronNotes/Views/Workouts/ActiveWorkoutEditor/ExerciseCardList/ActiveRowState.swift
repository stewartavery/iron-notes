//
//  ActiveRowState.swift
//  IronNotes
//
//  Created by Stewart Avery on 11/16/21.
//  Copyright © 2021 Stewart Avery. All rights reserved.
//

import Foundation


class ActiveRowState: ObservableObject {
  @Published var rowIndex: UUID?
}
