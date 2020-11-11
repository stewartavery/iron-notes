//
//  ExerciseCardList.swift
//  IronNotes
//
//  Created by Stewart Avery on 9/17/20.
//  Copyright © 2020 Stewart Avery. All rights reserved.
//

import SwiftUI

struct ExerciseCardList: View {
  @Environment(\.managedObjectContext) var moc
  @Environment(\.presentationMode) var presentationMode
  
  @EnvironmentObject var keyboardMonitor: KeyboardMonitor
  @EnvironmentObject var workout: Workout
  
  @Binding var workoutSheet: WorkoutSheet?
  
  @State private var bottomPadding: CGFloat = minCardHeight
  
  var body: some View {
    NavigationView {
      Group {
        if workout.routinesArray.count == 0 {
          VStack {
            Text("Your workout is empty. Add some")
            Text("exercises to get started.")
              .padding(.bottom)
            
            Button("Add Exercises") {
              workoutSheet = .exercises
            }
            .font(.headline)
            .accentColor(Color.orange)
          }
          .frame(maxWidth: .infinity, maxHeight: .infinity)
          .background(Color(.systemGroupedBackground))
        } else {
          List {
            ForEach(workout.routinesArray) { exercise in
              Section {
                ExerciseCard(exercise: exercise, isActive: true)
              }
            }
          }
          
          .listStyle(InsetGroupedListStyle())
        }
      }
      .onChange(of: keyboardMonitor.keyboardStatus, perform: { _ in
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
          bottomPadding = getBottomPadding(keyboardMonitor.keyboardStatus)
        }
      })
      .padding(.bottom, bottomPadding)
      .navigationBarTitle(Text("Workout Log"), displayMode: .inline)
      .toolbar {
        ToolbarItem(placement: .cancellationAction) {
          Button("Dismiss") {
            presentationMode.wrappedValue.dismiss()
          }
        }
        ToolbarItem(placement: .primaryAction) {
          TopToolbarContent(workoutSheet: $workoutSheet)
            .environmentObject(keyboardMonitor)
        }
      }
      .buttonStyle(BorderlessButtonStyle())
      .sheet(item: $workoutSheet) { workoutSheet in
        switch workoutSheet {
        case .exercises:
          ExerciseEditor(workout: workout)
            .environment(\.managedObjectContext, moc)
        case .workout:
          WorkoutMetaEditor(workout: workout)
            .environment(\.managedObjectContext, moc)
        }
      }
    }
  }
  
  private func getBottomPadding(_ keyboardStatus: KeyboardStatus) -> CGFloat {
    switch keyboardStatus {
    case .hidden:
      return minCardHeight
    case .presented(_):
      return 0
    }
  }
  
}
struct ExerciseCardList_Previews: PreviewProvider {
  @State static var workoutSheet: WorkoutSheet? = nil
  
  static var previews: some View {
    Group {
      ExerciseCardList(workoutSheet: $workoutSheet)
        .previewDevice("iPhone 11 Pro Max")
        .environmentObject(KeyboardMonitor())
        .environmentObject(IronNotesModelFactory.getWorkout())
      
      ExerciseCardList(workoutSheet: $workoutSheet)
        .previewDevice("iPhone 11 Pro Max")
        .environmentObject(KeyboardMonitor())
        .environmentObject(Workout.newWorkout())
      
      ExerciseCardList(workoutSheet: $workoutSheet)
        .previewDevice("iPhone 11 Pro Max")
        .environmentObject(KeyboardMonitor())
        .environment(\.colorScheme, .dark)
        .environmentObject(Workout.newWorkout())
      
      ExerciseCardList(workoutSheet: $workoutSheet)
        .previewDevice("iPhone SE")
        .environment(\.sizeCategory, .extraExtraLarge)
        .environment(\.colorScheme, .dark)
        .environmentObject(IronNotesModelFactory.getWorkout())
      
      
    }.environmentObject(KeyboardMonitor())
    
    
  }
}
