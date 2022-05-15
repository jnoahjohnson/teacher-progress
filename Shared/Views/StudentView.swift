//
//  StudentView.swift
//  Progress
//
//  Created by Noah Johnson on 4/10/22.
//

import SwiftUI
import SwiftUICharts

struct StudentView: View {
    @ObservedObject var student: Student
    @State private var showingAddScore = false
    @State private var addScore = 0
    
    var body: some View {
        LineChart(vals: student.scoresArray)
            .padding()
        
            .toolbar {
                ToolbarItem {
                    Button("Add Score") {
                        showingAddScore = true
                    }
                }
            }
            .sheet(isPresented: $showingAddScore) {
                AddScoreView(student: student)
            }
    }
}


//struct StudentView_Previews: PreviewProvider {
//    static var previews: some View {
//        StudentView(student: Student(firstName: "Noah", lastName: "Johnson", scores: [TestScore(score: 100)]))
//    }
//}
