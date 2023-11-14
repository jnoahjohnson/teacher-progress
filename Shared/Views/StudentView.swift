//
//  StudentView.swift
//  Progress
//
//  Created by Noah Johnson on 4/10/22.
//

import SwiftUI
import Charts

struct StudentView: View {
    @ObservedObject var studentViewModel: StudentViewModel
    @State private var showingAddScore = false
    @State private var addScore = 0
    
    var body: some View {
        VStack {
            ScrollView(.horizontal) {
                HStack {
                    VStack(alignment: .center) {
                        Text("Last Tested")
                            .font(.caption)
                        Text(studentViewModel.student.timeSinceLastAssessment)
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
            
            
            
            Chart(studentViewModel.student.scoresArray) { score in
                LineMark(x: .value("Date", score.wrappedDate), y: .value("Score", score.score))
                    .foregroundStyle(.indigo)
                    .symbol(Circle())
            }
            .padding()
            
            .toolbar {
                ToolbarItem {
                    Button("Add Score") {
                        showingAddScore = true
                    }
                }
            }
            .sheet(isPresented: $showingAddScore) {
                AddScoreView(onSave: { score in
                    studentViewModel.addScore(score)
                    showingAddScore = false
                })
            }
            
        }
        .navigationTitle(studentViewModel.student.fullName)
        .navigationBarTitleDisplayMode(.large)
    }
}


//struct StudentView_Previews: PreviewProvider {
//    static let student: Student = StudentViewModel
//    
//    init() {
//        let newStudent = Student()
//        
//        newStudent.firstName = "Noah"
//        newStudent.lastName = "Johnson"
//        
//        self.student = newStudent
//    }
//    
//    static var previews: some View {
//        
//        StudentView(studentViewModel: StudentViewModel(student: student))
//    }
//}
