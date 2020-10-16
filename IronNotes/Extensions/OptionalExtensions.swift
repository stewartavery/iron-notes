//
//  OptionalExtensions.swift
//  IronNotes
//
//  Created by Stewart Avery on 10/15/20.
//  Copyright © 2020 Stewart Avery. All rights reserved.
//

import SwiftUI

func ??<T>(lhs: Binding<Optional<T>>, rhs: T) -> Binding<T> {
    Binding(
        get: { lhs.wrappedValue ?? rhs },
        set: { lhs.wrappedValue = $0 }
    )
}
