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
  
  var isActive: Bool
  
  @State private var showDetail = false
  
  var body: some View {
    VStack(alignment: .leading) {
      HStack {
        Text(exercise.meta.name)
          .font(.headline)
          .padding(.top, 10)
        Spacer()
      }
      
      TextField("Notes", text: $exercise.note)
        .font(.subheadline)
        .foregroundColor(Color.gray)
        .padding(.vertical, 5)
    }
    ForEach(exercise.exerciseSetArray) { exerciseSet in
      ExerciseCardRow(exerciseSet: exerciseSet, isActive: isActive)
    }
    .onDelete(perform: deleteSet)
    .animation(showDetail ? .spring() : nil)
    .transition(.move(edge: .bottom))
    .onAppear() {
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
        showDetail = true
      }
    }
    
    if isActive {
      Button {
        withAnimation {
          createNewSet()
        }
      } label: {
        AddSet()
      }
    }
    
  }
  
  func deleteSet(at offsets: IndexSet) {
    for index in offsets {
      self.moc.delete(self.exercise.exerciseSetArray[index])
    }
    
    for reverseIndex in stride(
      from: exercise.exerciseSetArray.count - 1,
      through: 0,
      by: -1 ) {
      exercise.exerciseSetArray[reverseIndex].setPosition = Int16(reverseIndex)
    }
  }
  
  func createNewSet() {
    // TODO: consider what deleting workouts should do
    let newSet = ExerciseSet.newExerciseSet()
    newSet.setPosition = Int16(self.exercise.exerciseSetArray.count)
    newSet.reps = 3
    newSet.weight = 225
    newSet.exercise = exercise
    
    self.exercise.addToSets(newSet)
    
    do {
      try moc.save()
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
          ExerciseCard(exercise: IronNotesModelFactory.getExercise(), isActive: true)
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
