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
  
  let columns = [
    GridItem(.flexible()),
    GridItem(.flexible())
  ]
  
  var workoutMetaName: String {
    return workout.meta?.wrappedName ?? ""
  }
    
  var body: some View {
    VStack(alignment: .leading) {
      HStack {
        VStack(alignment: .leading) {
          Text(workoutMetaName)
            .font(.headline)
          CurrentRunningTime()
          
        }
        
        Spacer()
        
        WorkoutCardButton()
      }          .padding(.horizontal)

      
      Group {
        Divider()
        
        VStack(alignment: .leading) {
          if workout.isNotePresent {
            Text(workout.wrappedNote)
              .font(.body)
              .padding(.vertical)
            Divider()
          }
          
          LazyVGrid(columns: columns, spacing: 15) {
            WorkoutAction(title: "Change", icon: "note.text") {
              workoutSheet = .workout
            }
            
            WorkoutAction(title: "Edit", icon: "pencil") {
              workoutSheet = .exercises
            }
            
            WorkoutAction(title: "Remove", icon: "trash") {
              print("remove")
            }
          }
          .padding(.top)
        }
        .padding(.top)
        .padding(.horizontal)
      }
      .opacity(Double(cardDetails.opacity))
      
      Spacer()
    }
  }
}

#if DEBUG
struct WorkoutCard_Previews: PreviewProvider {
  @State static var workoutSheet: WorkoutSheet? = nil
  @State static var workoutStatus: WorkoutStatus = .stopped
  @StateObject static var cardDetails: CardDetails = CardDetails(position: .top, opacity: 1.0)
  
  static var previews: some View {
    WorkoutCard(workoutSheet: $workoutSheet)
      .environmentObject(StopwatchManager())
      .environmentObject(IronNotesModelFactory.getWorkout())
      .environmentObject(cardDetails)
      .environmentObject(WorkoutStore(managedObjectContext: PersistenceController.shared.container.viewContext))
      .background(Color(UIColor.systemGray6))
  }
}
#endif


