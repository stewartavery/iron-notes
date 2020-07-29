//
//  WorkoutDescription.swift
//  IronNotes
//
//  Created by Stewart Avery on 7/28/20.
//  Copyright © 2020 Stewart Avery. All rights reserved.
//

import SwiftUI

struct WorkoutButton: View {
  var label: String
  var systemImage: String
  var width: CGFloat
  
  var body: some View {
    Button {
      print("hey")
    } label: {
      Label(self.label, systemImage: self.systemImage)
        .foregroundColor(Color.orange)
        .font(.headline)
        .textCase(nil)
    }
    .padding(10)
    .frame(width: self.width)
    .mask(RoundedRectangle(cornerRadius: 8, style: .continuous))
    .padding(2)
    .background(Color.white)
    .cornerRadius(8)
  }
}

struct WorkoutDescription: View {
  @ObservedObject var workout: Workout
  
  var body: some View {
    GeometryReader { geometry in
      HStack {
        WorkoutButton(label: "Start", systemImage: "play.fill", width: geometry.size.width * 0.46)
        Spacer()
        WorkoutButton(label: "Edit", systemImage: "pencil", width: geometry.size.width * 0.46)
      }
    }
    .listRowInsets(EdgeInsets())
    .padding(.bottom, 55)

    
    
  }
}

struct WorkoutDescription_Previews: PreviewProvider {
  static var previews: some View {
    let workout = Workout(context: AppDelegate.viewContext)
    let workoutMeta = WorkoutTemplate(context: AppDelegate.viewContext)
    
    workoutMeta.name = "Extra Test Workout"
    workoutMeta.desc = "Really good workout!"
    workoutMeta.iconName = "barbell"
    workout.meta = workoutMeta
    workout.note = "This is an example of a relevant note to Bench Pressing."
    workout.startTime = Date()
    return
      List {
        Section(header: WorkoutDescription(workout: workout)) {
          Text("Hey")
        }
      }.listStyle(InsetGroupedListStyle())
  }
  
  
}
