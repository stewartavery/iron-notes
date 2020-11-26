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
        
        ScrollView {
          LazyVStack(spacing: 5) {
            Section(header: SummaryHeader("Workouts") {
              StartWorkoutList()
            }) {
              ForEach(0..<3) { _ in
                SummaryRow(
                  title: "Heart Rate",
                  description: "Your heart rate is 90 BPM.",
                  color: .red
                )
              }
            }
            Section(header: SummaryHeader("History") {
              WorkoutHistoryContainer()
            }) {
              ForEach(0..<3) { _ in
                SummaryRow(
                  title: "Heart Rate",
                  description: "Your heart rate is 90 BPM.",
                  color: .blue
                )
              }
            }
          }
          .padding(.horizontal)
        }
        
      }
      .navigationTitle("Summary")
    }
  }
}



struct SummaryView_Previews: PreviewProvider {
  static var previews: some View {
    SummaryView()
  }
}
