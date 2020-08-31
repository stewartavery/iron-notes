//
//  ExerciseList.swift
//  IronNotes
//
//  Created by Stewart Avery on 4/13/20.
//  Copyright © 2020 Stewart Avery. All rights reserved.
//

import SwiftUI

struct AddButton: View {
  var body: some View {
    HStack {
      Spacer()
      VStack {
        Image(systemName: "plus")
          .resizable()
          .scaledToFit()
      }
      .frame(width: 18, height: 18)
    }
    .frame(minWidth: 100, minHeight: 100)
    .contentShape(Rectangle())
  }
}

struct ExerciseList: View {
  @Environment(\.managedObjectContext) var moc
  @FetchRequest(entity: ExerciseTemplate.entity(),
                sortDescriptors: [NSSortDescriptor(keyPath: \ExerciseTemplate.name, ascending: true)]
  ) var exerciseTemplates: FetchedResults<ExerciseTemplate>
  @State var isCreateViewVisible = false
  
  var body: some View {
    NavigationView {
      List {
        ForEach(exerciseTemplates, id: \.self) { exerciseTemplate in
          NavigationLink(destination: ExerciseDetails()) {
            Text(exerciseTemplate.name)
              .font(.system(size: 16))
          }
        }
        .onDelete { indexSet in
          for index in indexSet {
            self.moc.delete(exerciseTemplates[index])
          }
        }
      }
      .listStyle(InsetGroupedListStyle())
      .sheet(isPresented: $isCreateViewVisible, content: { NewExercise(isPresented: self.$isCreateViewVisible) })
      .navigationBarTitle(Text("Exercises"), displayMode: .large)
      .navigationBarItems(
        trailing: Button {
          self.isCreateViewVisible.toggle()
        } label: {
          AddButton()
        })
    }
  }
}


struct ExerciseList_Previews: PreviewProvider {
  static var previews: some View {
    ExerciseList()
      .environment(\.managedObjectContext, AppDelegate.viewContext)
  }
}

