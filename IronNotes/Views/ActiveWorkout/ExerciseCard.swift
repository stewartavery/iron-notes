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
    HStack(alignment: .center) {
      Image(systemName: "plus.circle.fill")
        .rowIconCircle()
      
      Text("Add Set")
      Spacer()
    }
    .foregroundColor(Color.orange)
    .font(.headline)
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
    VStack(alignment: .leading) {
      HStack {
        Text(exercise.meta.name)
          .font(.headline)
          .padding(.top, 10)
        
        Spacer()
      }
      if self.isNotePresent {
        Text(exercise.note)
          .font(.subheadline)
          .foregroundColor(Color.gray)
          .padding(.top, 5)
      }
    }.padding(.bottom, 10)
    
    ForEach(exercise.exerciseSetArray, id: \.self) { exerciseSet in
      ExerciseCardRow(exerciseSet: exerciseSet)
    }
    .onDelete(perform: self.deleteSet)
    .animation(showDetail ? .spring() : nil)
    .transition(.move(edge: .bottom))
    .frame(height: 30)
    
    Button {
      withAnimation {
        self.createNewSet()
      }
    } label: {
      AddSet().frame(height: 35)
    }
    .onAppear() {
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
        self.showDetail = true
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
    } catch {
      print(error.localizedDescription)
    }
  }
}

#if DEBUG
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
#endif

#if DEBUG
struct AddSet_Previews: PreviewProvider {
  static var previews: some View {
    return AddSet()
  }
}
#endif
