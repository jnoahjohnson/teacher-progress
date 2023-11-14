//
//  StudentsView.swift
//  Progress
//
//  Created by Noah Johnson on 4/10/22.
//

import SwiftUI

//var initialStudents: [Student] = [
//    Student(firstName: "Joe", lastName: "Shmo", scores: [TestScore(score: 12), TestScore(score: 24), TestScore(score: 48), TestScore(score: 59), TestScore(score: 88), TestScore(score: 100)])
//]

struct StudentsView: View {
    @ObservedObject var classVM = ClassViewModel()
    @State private var showingAddStudent = false
    @State private var addScore = 0
    
    
    var body: some View {
        NavigationView {
            List {
                ForEach(classVM.studentViewModels) { studentViewModel in
                    NavigationLink {
                        StudentView(studentViewModel: studentViewModel)
                    } label: {
                        VStack(alignment: .leading) {
                            Text(studentViewModel.student.fullName)
                                .font(.headline)
                            
                            Text("\(studentViewModel.student.lastTestScore): \(studentViewModel.student.timeSinceLastAssessment)")
                                .font(.caption)
                            
                        }
                    }
                }
                .onDelete(perform: classVM.deleteStudent)
            }
            
            .navigationTitle("Students")
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddStudent.toggle()
                    } label: {
                        Label("Add Student", systemImage: "plus")
                    }
                }
            })
            .sheet(isPresented: $showingAddStudent) {
                AddStudentView(classVM: self.classVM)
            }
        }
    }
}

struct StudentsView_Previews: PreviewProvider {
    static let envObject = DataController()
    
    static var previews: some View {
        StudentsView()
            .environmentObject(envObject)
    }
}
