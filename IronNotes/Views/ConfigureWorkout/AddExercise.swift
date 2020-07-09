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
  
  var body: some View {
    NavigationView {
      List {
        ForEach(exerciseTemplates, id: \.self) { exerciseTemplate in
          HStack {
            Text(exerciseTemplate.name).font(.body)
            Spacer()
            Image(systemName: "plus.circle").foregroundColor(Color.orange)
          }
        }
      }
      .navigationBarTitle(Text("Add Exercises"), displayMode: .inline)
      .navigationBarItems(leading:
        Button("Cancel") {
          self.isPresented.toggle()
        },trailing: Button("Done") {
          self.isPresented.toggle()
      })      
    }
  }
  
}

struct AddExercise_Previews: PreviewProvider {
  @State static var isModalPresented = true
  
  static var previews: some View {
    AddExercise(isPresented: $isModalPresented)
      .environment(\.managedObjectContext, AppDelegate.viewContext)
    
  }
}
