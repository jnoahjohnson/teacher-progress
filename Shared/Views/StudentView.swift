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
        VStack {
            ScrollView(.horizontal) {
                HStack {
                    VStack(alignment: .center) {
                        Text("Last Tested")
                            .font(.caption)
                        Text(student.timeSinceLastAssessment)
                            .font(.headline)
      
                    }
                    .padding()
                    .background(.white)
                    .cornerRadius(8)
                    .shadow(radius: 4)
                }
                .padding()
            }
            .padding(.bottom)
            

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
        .navigationTitle(student.fullName)
        .navigationBarTitleDisplayMode(.large)
    }
}


//struct StudentView_Previews: PreviewProvider {
//    static var previews: some View {
//        StudentView(student: Student(firstName: "Noah", lastName: "Johnson", scores: [TestScore(score: 100)]))
//    }
//}
