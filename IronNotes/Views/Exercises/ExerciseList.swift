//
//  ExerciseList.swift
//  IronNotes
//
//  Created by Stewart Avery on 4/13/20.
//  Copyright © 2020 Stewart Avery. All rights reserved.
//

import SwiftUI

struct ExerciseList: View {
  @Environment(\.managedObjectContext) var moc
  @FetchRequest(entity: Exercise.entity(),
                sortDescriptors: [NSSortDescriptor(keyPath: \Exercise.name, ascending: true)]
  ) var exercises: FetchedResults<Exercise>
  @State var isCreateViewVisible = false
  
  
  var body: some View {
    NavigationView {
      List {
        ForEach(exercises, id: \.self) { exercise in
          Text(exercise.name).font(.body)
        }
      }
      .sheet(isPresented: $isCreateViewVisible, content: { NewExercise(isPresented: self.$isCreateViewVisible) })
      .navigationBarTitle(Text("Exercises"), displayMode: .large)
      .navigationBarItems(
        trailing: Button(action: {
          self.isCreateViewVisible.toggle()
        }) {
          HStack {
            Spacer()
            VStack {
              Image(systemName: "plus")
                .resizable()
                .aspectRatio(1, contentMode: .fit)
            }
            .frame(width: 18, height: 18)
          }
          .frame(minWidth: 100, minHeight: 100)
          .contentShape(Rectangle())
      })
        
        .onAppear(perform: resetTableView)
    }
  }
  
  func resetTableView() {
    UITableView.appearance().tableFooterView = UIView()
    UITableView.appearance().separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
  }
}


struct ExerciseList_Previews: PreviewProvider {
  static var previews: some View {
    ExerciseList()
      .environment(\.managedObjectContext, AppDelegate.viewContext)
      .onAppear() {
        
    }
  }
}

