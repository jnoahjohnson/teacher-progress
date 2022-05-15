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
    @EnvironmentObject var dataController: DataController
    @State private var showingAddStudent = false
    @State private var addScore = 0
    
    
    var body: some View {
        NavigationView {
            List {
                ForEach(dataController.students) { student in
                    NavigationLink {
                        StudentView(student: student)
                    } label: {
                        Text(student.fullName)
                    }
                }
                .onDelete(perform: dataController.deleteStudent)
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
                AddStudentView()
            }
        }
    }
}

struct StudentsView_Previews: PreviewProvider {
    static var previews: some View {
        StudentsView()
    }
}
