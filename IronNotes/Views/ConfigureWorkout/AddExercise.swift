//
//  AddExercise.swift
//  IronNotes
//
//  Created by Stewart Avery on 6/2/20.
//  Copyright © 2020 Stewart Avery. All rights reserved.
//

import SwiftUI

struct AddExercise: View {
  @Binding var isPresented: Bool
  @FetchRequest(entity: ExerciseTemplate.entity(),
                sortDescriptors: [NSSortDescriptor(keyPath: \ExerciseTemplate.name, ascending: true)]
  ) var exerciseTemplates: FetchedResults<ExerciseTemplate>
  var onComplete: ([ExerciseTemplate]) -> Void
  
  @State private var pendingExercises = [ExerciseTemplate]()
  
  var body: some View {
    NavigationView {
      List {
        Section(header: PendingExerciseHeader(pendingExercises: pendingExercises)) {
          ForEach(exerciseTemplates, id: \.self) { exerciseTemplate in
            AddExerciseRow(pendingExercises: $pendingExercises, exerciseTemplate: exerciseTemplate)
          }
        }
      }
      .listStyle(InsetGroupedListStyle())
      .navigationBarTitle(Text("Add Exercises"), displayMode: .inline)
      .navigationBarItems(leading:
                            Button("Cancel") {
                              self.isPresented.toggle()
                            },trailing: Button("Done") {
                              self.isPresented.toggle()
                              self.onComplete(self.pendingExercises)
                            })
    }
  }
  
  
}

struct PendingExerciseHeader: View {
  var pendingExercises: [ExerciseTemplate]
  
  var body: some View {
    let totalExercises = pendingExercises.count
    
    if totalExercises > 0 {
      return Text("\(totalExercises) exercise\(totalExercises == 1 ? "" : "s") added to Workout.")
    }
    
    return Text("")
  }
}

struct AddExerciseRow: View {
  @Binding var pendingExercises: [ExerciseTemplate]
  var exerciseTemplate: ExerciseTemplate
  @Environment(\.colorScheme) var colorScheme: ColorScheme
  
  
  var body: some View {
    Button {
      self.handleSelection()
    } label: {
      HStack {
        Text(self.exerciseTemplate.name)
          .font(.body)
          .foregroundColor(colorScheme == .light ? Color.black : Color.white)
        Spacer()
        if self.pendingExercises.contains(self.exerciseTemplate) {
          Image(systemName: "checkmark")
            .foregroundColor(Color.orange)
            .animation(.easeIn)
          
        } else {
          Image(systemName: "plus.circle")
            .foregroundColor(Color.orange)
            .animation(.easeIn)
        }
        
      }
    }
  }
  
  func handleSelection() {
    if self.pendingExercises.contains(exerciseTemplate) {
      self.pendingExercises.removeAll(where: { $0 == exerciseTemplate })
    }
    else {
      self.pendingExercises.append(exerciseTemplate)
    }
  }
}


func testFunc(templates: [ExerciseTemplate]) {
  print("Test")
}

struct AddExercise_Previews: PreviewProvider {
  @State static var isModalPresented = true
  
  
  static var previews: some View {
    AddExercise(isPresented: $isModalPresented, onComplete: testFunc)
      .environment(\.managedObjectContext, AppDelegate.viewContext)
    
  }
}
