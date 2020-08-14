//
//  ActiveWorkout.swift
//  IronNotes
//
//  Created by Stewart Avery on 2/16/20.
//  Copyright © 2020 Stewart Avery. All rights reserved.
//

import SwiftUI
import CoreData
import Combine

struct OptionalWorkoutDescription: View {
  @EnvironmentObject var workout: Workout
  @Binding var isEditing: Bool
  
  var isVisible: Bool
  
  var body: some View {
    if isVisible {
      WorkoutDescription(workout: workout, isEditing: $isEditing)
    }
  }
}

struct OptionalFooter: View {
  
  var isVisible: Bool
  
  var body: some View {
    if isVisible {
      VStack{
        
      }.keyboardAdaptive()
    }
  }
}

struct ActiveWorkout: View {
  @EnvironmentObject var workout: Workout
  @Environment(\.managedObjectContext) var moc
  @State var isEditing = false
  @State var isModifyingSet: Bool = false
  
  var body: some View {
    print(workout.routinesArray)
    return List {
      ForEach(workout.routinesArray.sorted(by: {$0.position < $1.position}), id: \.self) { exercise in
        Section(
          header: OptionalWorkoutDescription(
            isEditing: $isEditing,
            isVisible: exercise.position == 0
          ), footer: OptionalFooter(isVisible: exercise.position == workout.routinesArray.count - 1)
        ) {
          ExerciseCard(exercise: exercise)
        }
      }
    }
    
    
    .buttonStyle(BorderlessButtonStyle())
    .sheet(
      isPresented: self.$isEditing,
      content: {
        ExerciseEditor(isPresented: self.$isEditing)
          .environment(\.managedObjectContext, moc)
      })
    .listStyle(InsetGroupedListStyle())
    .navigationBarTitle(Text(workout.meta.name), displayMode: .large)
  }
  
  
  func createNewSet(exercise: Exercise) {
    let newSet = ExerciseSet(context: moc)
    newSet.setPosition = Int16(exercise.exerciseSetArray.count + 1)
    exercise.addToSets(newSet)
    
    do {
      try self.moc.save()
      print("Set added.")
    } catch {
      print(error.localizedDescription)
    }
  }
}

extension UIApplication {
  func endEditing() {
    sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
  }
}

#if DEBUG
struct ActiveWorkout_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      ActiveWorkout()
    }
    .navigationViewStyle(StackNavigationViewStyle())
    .environmentObject(IronNotesModelFactory.getWorkout())
    .environmentObject(StopwatchManager())
  }
}
#endif
