//
//  WorkoutCard.swift
//  IronNotes
//
//  Created by Stewart Avery on 8/29/20.
//  Copyright © 2020 Stewart Avery. All rights reserved.
//

import SwiftUI

struct WorkoutCard: View {
  
  @EnvironmentObject var stopwatchManager: StopwatchManager
  @EnvironmentObject var cardDetails: CardDetails
  @EnvironmentObject var workout: Workout
  
  @Binding var workoutSheet: WorkoutSheet?
  
  var body: some View {
    VStack(alignment: .leading) {
      switch stopwatchManager.mode {
      case .running:
        HStack {
          StatusContent()
          Spacer()
          BottomBarContent()
        }
      case .stopped:
        StartButton()
      }
      
      switch cardDetails.position {
      case .middle, .top:
        ScrollView {
          VStack(alignment: .leading) {
            WorkoutRowLabel(workoutTemplate: workout.meta)
            
            Divider()
            
            if workout.isNotePresent {
              Text(workout.wrappedNote)
                .font(.body)
                .padding(.top)
            }
            
            VStack(alignment: .leading) {
              
              Button {
                workoutSheet = .workout
              } label: {
                HStack {
                  Label("Change Workout", systemImage: "note.text")
                  Spacer()
                }.padding()
                .gesture(DragGesture(minimumDistance: 0)
                          .onChanged { _ in }
                          .onEnded { _ in }
                      )
              }
              
              
              Divider()
              Button {
                workoutSheet = .exercises
              } label: {
                HStack {
                  Label("Edit Exercises", systemImage: "pencil")
                  Spacer()
                }.padding()
              }
              
              
              Divider()
              
              Button {
                print("remove")
              } label: {
                HStack {
                  Label("Remove Workout", systemImage: "trash")
                  Spacer()
                }.padding()
              }
              .foregroundColor(Color.red)
              
            }
            .foregroundColor(Color.orange)
            .font(.headline)
            
            
            Spacer()
          }
        }.padding(.top)
        
      case .bottom:
        Spacer()
      }
    }
    .padding(.horizontal)
    
  }
}

#if DEBUG
struct WorkoutCard_Previews: PreviewProvider {
  @State static var workoutSheet: WorkoutSheet? = nil
  @State static var workoutStatus: WorkoutStatus = .stopped
  @StateObject static var cardDetails: CardDetails = CardDetails(position: .top)
  
  static var previews: some View {
    WorkoutCard(workoutSheet: $workoutSheet)
      .environmentObject(StopwatchManager())
      .environmentObject(IronNotesModelFactory.getWorkout())
      .environmentObject(cardDetails)
      .environmentObject(WorkoutStore(managedObjectContext: PersistenceController.shared.container.viewContext))
  }
}
#endif
