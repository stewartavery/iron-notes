//
//  ExerciseCard.swift
//  IronNotes
//
//  Created by Stewart Avery on 3/12/20.
//  Copyright © 2020 Stewart Avery. All rights reserved.
//

import SwiftUI

struct ExerciseCard: View {
  
  
  var exercise: Exercise
   
  var body: some View {
    VStack(alignment: .leading) {
      Text(exercise.name)
        .font(.headline)
        .foregroundColor(Color.orange)
        .padding(.bottom, 20)
      
      
      ForEach(exercise.exerciseSetArray, id: \.self) { exerciseSet in
        VStack {
          HStack {
            VStack(alignment: .leading) {
              Text(String(exerciseSet.weight) + " lbs")
                .font(.subheadline)
              VStack(alignment: .trailing) {
                Text(String(exerciseSet.reps) + " Reps")
                  .font(.subheadline)
              }
            }
            Spacer()
          }
          Divider()
          
        }
        
      }.frame(height: 60)
    }
    .padding()
    .background(Color.white)
    .cornerRadius(10)
    
  }
}

struct ExerciseCard_Previews: PreviewProvider {
  static var previews: some View {
    let exercise = Exercise(context: AppDelegate.viewContext)
    exercise.name = "Test"
    exercise.position = 0
    
    let exerciseSet = ExerciseSet(context: AppDelegate.viewContext)
    exerciseSet.setPosition=0
    exerciseSet.reps = 3
    exerciseSet.weight = 135
    exercise.addToSets(exerciseSet)
    
    let exerciseSet2 = ExerciseSet(context: AppDelegate.viewContext)
    exerciseSet.setPosition = 1
    exerciseSet2.reps = 3
    exerciseSet2.weight = 225
    exercise.addToSets(exerciseSet2)
    
    return ExerciseCard(exercise: exercise)
    
  }
}
