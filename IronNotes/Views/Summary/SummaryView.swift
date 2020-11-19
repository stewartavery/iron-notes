//
//  SummaryView.swift
//  IronNotes
//
//  Created by Stewart Avery on 11/16/20.
//  Copyright © 2020 Stewart Avery. All rights reserved.
//

import SwiftUI

struct SummaryView: View {
  var body: some View {
    NavigationView {
      ZStack {
        Color(.systemGroupedBackground)
          .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        
        VStack {
          ScrollView {
            LazyVStack(spacing: 5) {
              Section(header: SummaryHeader("Workouts") {
                StartWorkoutList()
              }) {
                ForEach(0..<3) { _ in
                  GroupBox(label: ContainerRelativeShape()
                            .fill(Color.blue)
                            .frame(width: 10)) {
                    VStack(alignment: .leading) {
                      Text("Heart Rate")
                        .font(.headline)
                      
                      Text("Your heart rate is 90 BPM.")
                        .foregroundColor(.gray)
                    }
                  }.groupBoxStyle(CardGroupBoxStyle())
                }
              }
              Section(header: SummaryHeader("History") {
                WorkoutHistoryContainer()
              }) {
                
                ForEach(0..<3) { _ in
                  GroupBox(label: ContainerRelativeShape()
                            .fill(Color.red)
                            .frame(width: 10)) {
                    VStack(alignment: .leading) {
                      Text("Heart Rate")
                        .font(.headline)
                      
                      Text("Your heart rate is 90 BPM.")
                        .foregroundColor(.gray)
                    }
                  }.groupBoxStyle(CardGroupBoxStyle())
                }
              }
            }
            .padding()
          }
        }
      }
      .navigationTitle("Summary")
    }
  }
}

struct CardGroupBoxStyle: GroupBoxStyle {
  func makeBody(configuration: Configuration) -> some View {
    HStack {
      configuration.label
      
      configuration.content
        .padding()
      
      Spacer()
      
      Image(systemName: "chevron.forward")
        .resizable()
        .scaledToFit()
        .frame(width: 12, height: 12)
        .foregroundColor(Color.gray)
        .padding()
    }
    .background(Color(.secondarySystemGroupedBackground))
    .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
  }
}

struct SummaryView_Previews: PreviewProvider {
  static var previews: some View {
    SummaryView()
  }
}
