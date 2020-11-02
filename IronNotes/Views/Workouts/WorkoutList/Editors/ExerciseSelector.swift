//
//  ExerciseSelector.swift
//  IronNotes
//
//  Created by Stewart Avery on 10/25/20.
//  Copyright © 2020 Stewart Avery. All rights reserved.
//

import SwiftUI

struct TestTemplate: Identifiable {
  var name: String
  var id: UUID
}

extension TestTemplate {
  static let preview1: [TestTemplate] = [
      TestTemplate(name: "Test A", id: UUID()),
      TestTemplate(name: "Test B", id: UUID()),
      TestTemplate(name: "Test C", id: UUID())
  ]
}

struct ExerciseSelector: View {
  var exerciseTemplates: [TestTemplate]
  
  @State var selectedRow: UUID? = nil
  
  var body: some View {
    List {
      ForEach(exerciseTemplates) { exercise in
        DisclosureGroup(exercise.name) {
          Text("Hey")
        }
      }
    }
  }
  
  private func handleRowSelection(_ id: UUID) {
    selectedRow = selectedRow == id ? nil : id
  }
}

struct ExerciseSelector_Previews: PreviewProvider {
  static var previews: some View {
    ExerciseSelector(exerciseTemplates: TestTemplate.preview1)
      .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
    
  }
}
