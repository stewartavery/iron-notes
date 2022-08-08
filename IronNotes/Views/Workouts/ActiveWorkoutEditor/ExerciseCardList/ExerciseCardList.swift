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
    
    @EnvironmentObject var activeWorkout: ActiveWorkout
    @EnvironmentObject var stopwatchManager: StopwatchManager
    
    @Binding var workoutSheet: WorkoutSheet?
    
    private var workout: Workout {
        return activeWorkout.workout
    }
    
    private var workoutMetaName: String {
        return workout.meta?.wrappedName ?? "New Workout"
    }
    
    var body: some View {
        NavigationView {
            Group {
                if workout.routinesArray.count > 0 {
                    List {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(workoutMetaName)
                                    .font(.headline)
                                CurrentRunningTime()
                            }
                            Spacer()
                            WorkoutCardButton()
                        }
                        .listRowBackground(Color(.systemGroupedBackground))
                        .listRowInsets(EdgeInsets())
                        ForEach(workout.routinesArray) { exercise in
                            Section {
                                ExerciseCard(exercise: exercise, isActive: true)
                            }
                        }
                    }
                    .listStyle(InsetGroupedListStyle())
                } else {
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
                    
                }
            }
            .navigationTitle("Workout Log")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Dismiss") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                ToolbarItem(placement: .primaryAction) {
                    TopToolbarContent(workoutSheet: $workoutSheet)
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
}

struct ExerciseCardList_Previews: PreviewProvider {
    @State static var workoutSheet: WorkoutSheet? = nil
    
    static var previews: some View {
        Group {
            ExerciseCardList(workoutSheet: $workoutSheet)
                .previewDevice("iPhone 11 Pro Max")
            
            ExerciseCardList(workoutSheet: $workoutSheet)
                .previewDevice("iPhone 11 Pro Max")
            
            ExerciseCardList(workoutSheet: $workoutSheet)
                .previewDevice("iPhone 11 Pro Max")
                .environment(\.colorScheme, .dark)
            
            ExerciseCardList(workoutSheet: $workoutSheet)
                .previewDevice("iPhone SE")
                .environment(\.sizeCategory, .extraExtraLarge)
                .environment(\.colorScheme, .dark)
            
        }
        .environmentObject(KeyboardMonitor())
        .environmentObject(ActiveWorkout.pendingWorkout)
    }
}
