//
//  WorkoutRow.swift
//  IronNotes
//
//  Created by Stewart Avery on 7/21/19.
//  Copyright © 2019 Stewart Avery. All rights reserved.
//

import SwiftUI
import CoreData

/**
 NSSortDescriptor *dateSort = [NSSortDescriptor sortDescriptorWithKey:@"date" ascending:NO];
 fetch.sortDescriptors = @[ dateSort ];
 fetch.fetchLimit = 1;
 */

/**
 var predicate:String
 var wordsRequest : FetchRequest<Word>
 var words : FetchedResults<Word>{wordsRequest.wrappedValue}
 
 init(predicate:String){
 self.predicate = predicate
 self.wordsRequest = FetchRequest(entity: Word.entity(), sortDescriptors: [], predicate:
 NSPredicate(format: "%K == %@", #keyPath(Word.character),predicate))
 
 }
 */

struct WorkoutRowLabel: View {
  @Environment(\.colorScheme) var colorScheme: ColorScheme
  
  var workoutTemplate: WorkoutTemplate
  var workoutRequest: FetchRequest<Workout>
  var workout: FetchedResults<Workout> {
    workoutRequest.wrappedValue
  }
  
  init(workoutTemplate: WorkoutTemplate) {
    self.workoutTemplate = workoutTemplate
    let request: NSFetchRequest<Workout> = Workout.fetchRequest()
    request.fetchLimit = 1
    request.sortDescriptors = [
      NSSortDescriptor(keyPath: \Workout.startTime, ascending: false)
    ]
    request.predicate = NSPredicate(
      format: "%K == %@",
      #keyPath(Workout.meta.name),
      workoutTemplate.name
    )
    
    self.workoutRequest = FetchRequest<Workout>(fetchRequest: request)
  }
  
  var body: some View {
      return VStack(alignment: .leading) {
        Text(workoutTemplate.name)
          .font(.headline)
        Text(workoutTemplate.desc)
          .font(.subheadline)
        if workout.count == 1 {
          Text(getWorkoutDate(workout: workout[0]))
          .font(.subheadline)
          .foregroundColor(.gray)
        }
      }.accentColor(colorScheme == .light ? Color.black : Color.white)
    
  }
  
  func getWorkoutDate(workout: Workout) -> String {
    return "Last Workout: " +
      workout.dayDifference(
        from: workout.wrappedStartTime
      )
  }
}

struct WorkoutRow: View {
  var workoutTemplate: WorkoutTemplate
  
  var body: some View {
    HStack {
      RowImage(iconName: workoutTemplate.iconName)
      
      WorkoutRowLabel(workoutTemplate: workoutTemplate)
        .padding(.leading, CGFloat(10))
    }
    .frame(height: 80)
  }
}

#if DEBUG
struct WorkoutRow_Previews: PreviewProvider {
  static var previews: some View {
    let context = PersistenceController.shared.container.viewContext
    let workout = Workout(context: context)
    let workoutMeta = WorkoutTemplate(context: context)
    workoutMeta.name = "Test"
    workoutMeta.iconName = "barbell"
    workoutMeta.desc = "Test Description"
    workout.meta = workoutMeta
    workout.startTime = Date()
    workout.routines = []
    
    
    return Group {
      WorkoutRow(workoutTemplate: workoutMeta)
        .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
    }
    
    
  }
}
#endif
