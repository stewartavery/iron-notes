//
//  ExerciseCard.swift
//  IronNotes
//
//  Created by Stewart Avery on 3/12/20.
//  Copyright © 2020 Stewart Avery. All rights reserved.
//

import SwiftUI

struct AddSet: View {
  var body: some View {
    Label("Add Set", systemImage: "plus.circle.fill")
      .font(.headline)
      .foregroundColor(Color.orange)
      .frame(height: 40)
      .padding(.bottom, 5)
  }
}

struct ExerciseCard: View {
  @Environment(\.managedObjectContext) var moc
  @ObservedObject var exercise: Exercise
  @State private var showDetail = false
  
  var isNotePresent: Bool {
    return exercise.note.count > 0
  }
  
  var body: some View {
    Group {
      VStack(alignment: .leading) {
        Text(exercise.meta.name)
          .font(.headline)
          .foregroundColor(Color.orange)
          .padding(.top, 10)
        if self.isNotePresent {
          Text(exercise.note)
            .font(.system(size: 15, weight: .semibold, design: .default))
            .padding(.top, 5)
        }
      }.padding(.bottom, 10)
      
      ForEach(exercise.exerciseSetArray, id: \.self) { exerciseSet in
        ExerciseCardRow(exerciseSet: exerciseSet)
      }
      .onDelete(perform: self.deleteSet)
      .animation(showDetail ? .spring() : nil)
      .transition(.move(edge: .bottom))
      .frame(height: 40)
      Button {
        withAnimation {
          self.createNewSet()
        }
      } label: {
        AddSet()
      }
      .onAppear() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
          self.showDetail = true
        }
      }
    }
  }
  
  func deleteSet(at offsets: IndexSet) {
    var modifiedExerciseSets = self.exercise.exerciseSetArray
    modifiedExerciseSets.remove(atOffsets: offsets)
    
    for index in offsets {
      self.moc.delete(self.exercise.exerciseSetArray[index])
    }
    
    for reverseIndex in stride(
      from: modifiedExerciseSets.count - 1,
      through: 0,
      by: -1 ) {
      modifiedExerciseSets[reverseIndex].setPosition = Int16(reverseIndex)
    }
  }
  
  func createNewSet() {
    let newSet = ExerciseSet(context: moc)
    newSet.setPosition = Int16(self.exercise.exerciseSetArray.count)
    newSet.reps = 3
    newSet.weight = 225
    newSet.exercise = exercise
    
    self.exercise.addToSets(newSet)
    
    do {
      try self.moc.save()
      print("Set added.")
    } catch {
      print(error.localizedDescription)
    }
  }
}

struct ExerciseCard_Previews: PreviewProvider {
  static var previews: some View {
    return NavigationView {
      List {
        Section {
          ExerciseCard(exercise: IronNotesModelFactory.getExercise())
        }
      }
      .listStyle(InsetGroupedListStyle())
      .navigationTitle("Hey")
      .buttonStyle(BorderlessButtonStyle())
    }
    
  }
}
