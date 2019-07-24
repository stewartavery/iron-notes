//
//  WorkoutRow.swift
//  IronNotes
//
//  Created by Stewart Avery on 7/21/19.
//  Copyright © 2019 Stewart Avery. All rights reserved.
//

import SwiftUI

struct WorkoutRow: View {
    var label: String
    var desc: String
    var icon: String
    var lastWorkout: Date
    
    var body: some View {
        
        HStack {
            Image(self.icon)
                .resizable()
                .frame(width: 50, height: 50)
                .padding()
                .border(Color.black, width: 1, cornerRadius: 5)
            
            VStack(alignment: .leading) {
                Text(self.label)
                    .font(.headline)
                Text(self.desc)
                    .font(.subheadline)
                Text("Last Workout: " + dayDifference(from: self.lastWorkout))
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }.padding(.leading, 10)
        }
        .frame(height: 100)
    }
}

func dayDifference(from date : Date) -> String {
    let calendar = Calendar.current
    if calendar.isDateInYesterday(date) { return "Yesterday" }
    else if calendar.isDateInToday(date) { return "Today" }
    else if calendar.isDateInTomorrow(date) { return "Tomorrow" }
    else {
        let startOfNow = calendar.startOfDay(for: Date())
        let startOfTimeStamp = calendar.startOfDay(for: date)
        let components = calendar.dateComponents([.day], from: startOfNow, to: startOfTimeStamp)
        let day = components.day!
        if day < 1 { return "\(-day) days ago" }
        else { return "In \(day) days" }
    }
}


#if DEBUG
struct WorkoutRow_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutRow(label: "Push", desc: "Bench press, shoulder press, tricep extension", icon: "dumbbell", lastWorkout: Date())
    }
}
#endif


