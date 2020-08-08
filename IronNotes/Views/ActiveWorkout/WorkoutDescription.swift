//
//  WorkoutDescription.swift
//  IronNotes
//
//  Created by Stewart Avery on 7/28/20.
//  Copyright © 2020 Stewart Avery. All rights reserved.
//

import SwiftUI

struct WorkoutButton: View {
  @Environment(\.colorScheme) var colorScheme: ColorScheme
  
  var label: String
  var systemImage: String
  var width: CGFloat
  
  var body: some View {
    HStack {
      Label(self.label, systemImage: self.systemImage)
        .foregroundColor(Color.orange)
        .font(.headline)
        .textCase(nil)
        .padding(10)
        .frame(width: self.width)
        .mask(RoundedRectangle(cornerRadius: 8, style: .continuous))
        .padding(2)
        .background(colorScheme == .light ? Color.white : Color(UIColor.systemGray6))
        .cornerRadius(8)
      Spacer()
    }
  }
}

struct WorkoutDescription: View {
  @ObservedObject var workout: Workout
  @Binding var isEditing: Bool
  @EnvironmentObject var stopwatchManager: StopwatchManager
  
  var body: some View {
    GeometryReader { geometry in
      HStack {
        switch stopwatchManager.mode {
        case .running:
          Button {
            stopwatchManager.pause()
          } label: {
            WorkoutButton(label: "\(stopwatchManager.secondsElapsed.asString(style: .positional))", systemImage: "pause.fill", width: geometry.size.width * 0.46)
          }
        case .paused:
          Button {
            stopwatchManager.start()
          } label: {
            WorkoutButton(label: "\(stopwatchManager.secondsElapsed.asString(style: .positional))", systemImage: "play.fill", width: geometry.size.width * 0.46)
          }
        case .stopped:
          Button {
            stopwatchManager.start()
          } label: {
            WorkoutButton(label: "Start", systemImage: "play.fill", width: geometry.size.width * 0.46)
          }
        }
        Spacer()
        Button {
          self.isEditing.toggle()
        } label: {
          WorkoutButton(label: "Edit", systemImage: "pencil", width: geometry.size.width * 0.46 )
        }
        
      }
    }
    .listRowInsets(EdgeInsets())
    .padding(.bottom, 55)
    .padding(.top, 5)
  }
  
}

#if DEBUG
struct WorkoutDescription_Previews: PreviewProvider {
  @State static var isEditing = true
  
  static var previews: some View {
    return
      List {
        Section(header: WorkoutDescription(
          workout: IronNotesModelFactory.getWorkout(),
          isEditing: $isEditing
        )) {
          Text("Hey")
        }
      }.listStyle(InsetGroupedListStyle())
      .environment(\.colorScheme, .dark)
      .environmentObject(StopwatchManager())
  }
}
#endif
