//
//  ExerciseCard.swift
//  IronNotes
//
//  Created by Stewart Avery on 3/12/20.
//  Copyright © 2020 Stewart Avery. All rights reserved.
//

import SwiftUI

struct ExerciseCard: View {
  
  
  var exerciseDetail: ExerciseDetail
  
  var body: some View {
    VStack(alignment: .leading) {
      Text(exerciseDetail.wrappedName)
        .font(.headline)
        .padding(.bottom, 20.0)
      
      Divider()
      
      ForEach(exerciseDetail.exerciseSetArray, id: \.self) { exerciseSet in
        VStack {
          HStack {
            VStack(alignment: .leading) {
              Text("Weight")
                .font(.headline)
              Text(String(exerciseSet.weight) + " lbs")
                .font(.subheadline)
            }
            Spacer()
            VStack(alignment: .trailing) {
              Text("Reps")
                .font(.headline)
              Text(String(exerciseSet.reps))
                .font(.subheadline)
            }
            
          }
          Divider()
          
        }
        
      }.frame(height: 60)
    }
    .padding()
    .background(Color.white)
    .cornerRadius(10)
    .overlay(
      RoundedRectangle(cornerRadius: 10)
        .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.1), lineWidth: 1)
      
    )
      .padding([.top, .horizontal])
    
  }
}

struct ExerciseCard_Previews: PreviewProvider {
  static var previews: some View {
    let exerciseDetail = ExerciseDetail(context: AppDelegate.viewContext)
    exerciseDetail.name = "Test"
    exerciseDetail.exerciseDetailIndex = 0
    
    let exerciseSet = ExerciseSet(context: AppDelegate.viewContext)
    exerciseSet.exerciseSetIndex = 0
    exerciseSet.reps = 3
    exerciseSet.weight = 2
    exerciseDetail.addToSets(exerciseSet)
    
    let exerciseSet2 = ExerciseSet(context: AppDelegate.viewContext)
    exerciseSet.exerciseSetIndex = 0
    exerciseSet.reps = 3
    exerciseSet.weight = 2
    exerciseDetail.addToSets(exerciseSet2)
    
    return ExerciseCard(exerciseDetail: exerciseDetail)
    
  }
}
