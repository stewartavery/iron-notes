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
      Text(exercise.meta.name)
        .font(.headline)
        .foregroundColor(Color.orange)
        .padding(.bottom, 15)
      
      Text("Here is where a useful note would go.")
        .font(.callout)
      
      Divider()
      ForEach(exercise.exerciseSetArray, id: \.self) { exerciseSet in
        VStack {
          HStack {
            VStack {
              CompletionCircle().padding(.top, 4)
              Spacer()
            }
            VStack {
              HStack(alignment: .firstTextBaseline, spacing: 2) {
                Text(String(exerciseSet.weight))
                  .font(.headline)
                Text("lbs")
                  .font(.caption)
                  .foregroundColor(Color.gray)
                
                Spacer()
                
                Text(String(exerciseSet.reps))
                  .font(.headline)
                Text("reps")
                  .font(.caption)
                  .foregroundColor(Color.gray)
              }
              Spacer()
              RoundedRectangle(cornerRadius: 5)
                .foregroundColor(Color.orange)
            }
          }.padding(.bottom, 20)
            .padding(.top, 10)
          Divider()
        }
        
      }.frame(height: 80)
    }
    .padding()
    .background(Color.white)
    .cornerRadius(10)
    
  }
}

struct ExerciseCard_Previews: PreviewProvider {
  static var previews: some View {
    let exercise = Exercise(context: AppDelegate.viewContext)
    let exerciseMeta = ExerciseTemplate(context: AppDelegate.viewContext)
    exerciseMeta.name = "Test"
    exercise.meta = exerciseMeta
    exercise.position = 0
    
    let exerciseSet = ExerciseSet(context: AppDelegate.viewContext)
    exerciseSet.setPosition = 0
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
