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
  
  @State private var editMode = EditMode.inactive

  @State private var bottomPadding: CGFloat = minCardHeight
  @State private var isOnlyTitleVisible: Bool = false
  
  var body: some View {
    NavigationView {
      List {
        ForEach(workout.routinesArray) { exercise in
          ExerciseCard(exercise: exercise, isActive: true, isOnlyTitleVisible: isOnlyTitleVisible)
            .environment(\.editMode, Binding.constant(EditMode.active))

        }.onMove(perform: moveRow)

        
        Button("toggle") {
          withAnimation {
            isOnlyTitleVisible.toggle()
            editMode = isOnlyTitleVisible ? EditMode.active : EditMode.inactive
          }
        }
      }
      .environment(\.editMode, $editMode)

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
      .listStyle(InsetGroupedListStyle())
    }
  }
  
  func moveRow(from source: IndexSet, to destination: Int) {
    print(destination)
    var modifiedRoutines = workout.routinesArray
    modifiedRoutines.move(fromOffsets: source, toOffset: destination)
    
    for reverseIndex in stride(
      from: modifiedRoutines.count - 1,
      through: 0,
      by: -1) {
      modifiedRoutines[reverseIndex].position = Int16(reverseIndex)
    }
    
    print(modifiedRoutines)
    
    do {
      try moc.save()
    } catch {
      print(error.localizedDescription)
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
      
      ExerciseCardList(workoutSheet: $workoutSheet)
        .previewDevice("iPhone SE")
        .environment(\.sizeCategory, .extraExtraLarge)
        .environment(\.colorScheme, .dark)
      
      
    }
    .environmentObject(KeyboardMonitor())
    .environmentObject(IronNotesModelFactory.getWorkout())
  }
}
