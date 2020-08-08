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
  @ObservedObject var workout: Workout
  @Binding var isEditing: Bool
  
  var isVisible: Bool
  
  var body: some View {
    if isVisible {
      WorkoutDescription(workout: workout, isEditing: $isEditing)
    }
  }
}

struct ActiveWorkout: View {
  @ObservedObject var workout: Workout
  @Environment(\.managedObjectContext) var moc
  @State var isEditing = false
  @State var isModifyingSet: Bool = false
  
  var body: some View {
    List {
      ForEach(workout.routinesArray, id: \.self) { exercise in
        Section(
          header: OptionalWorkoutDescription(
            workout: workout,
            isEditing: $isEditing,
            isVisible: exercise.position == 0
          )
        ) {
          ExerciseCard(exercise: exercise)
        }
      }
    }
    .buttonStyle(BorderlessButtonStyle())
    .sheet(
      isPresented: self.$isEditing,
      content: {
        ExerciseEditor(
          workout: self.workout,
          isPresented: self.$isEditing
        )
      })
    .listStyle(InsetGroupedListStyle())
    .navigationBarTitle(Text(workout.meta.name), displayMode: .large)
    .navigationBarItems(
      trailing: Button("Save") {
        self.isModifyingSet = false
        UIApplication.shared.endEditing()
      })
    
  }
  
  
  func createNewSet(exercise: Exercise) {
    let newSet = ExerciseSet(context: moc)
    newSet.setPosition = Int16(exercise.exerciseSetArray.count + 1)
    newSet.reps = 3
    newSet.weight = 225
    
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
    return NavigationView {
      ActiveWorkout(workout: IronNotesModelFactory.getWorkout())
    }.navigationViewStyle(StackNavigationViewStyle())
    .environmentObject(StopwatchManager())
  }
}
#endif
