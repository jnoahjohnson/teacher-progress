//
//  AddTest.swift
//  Progress
//
//  Created by Noah Johnson on 5/3/22.
//

import SwiftUI
import Introspect

@MainActor class StudentWithScore: ObservableObject {
    let student: Student
    @Published var score: String = ""
    
    init(student: Student) {
        self.student = student
    }
}

@MainActor class AddTestViewModel: ObservableObject {
    @Environment(\.dismiss) var dismiss
    var dataController: DataController
    
    var studentIndex: Int = 0 {
        willSet(newValue) {
            self.current = self.studentScores[newValue]
            
            // Check if first
            if (newValue == 0 ) {
                self.isFirst = true
            } else {
                self.isFirst = false
            }
            
            
            if (newValue == studentScores.count - 1) {
                self.isLast = true
            } else {
                self.isLast = false
            }
        }
    }
    
    @Published var studentScores: [StudentWithScore] = []
    @Published var current: StudentWithScore
    
    @Published var isFirst: Bool = true
    @Published var isLast: Bool
    
    var numStudents: Int {
        self.studentScores.count
    }
    
    var currentStudent: Student {
        self.studentScores[studentIndex].student
    }
    
    var currentScore: String {
        get {
            self.studentScores[studentIndex].score
        }
        set(score) {
            self.studentScores[studentIndex].score = score
        }
    }
    
    init(students: [Student], dataController: DataController) {
        let initialStudents = students.map{ StudentWithScore(student: $0) }
        self.studentScores = initialStudents
        self.current = initialStudents[0]
        
        self.isLast = initialStudents.count == 1
        self.dataController = dataController
    }
    
    func saveStudents() {
        for studentScore in studentScores {
            if let score = Int16(studentScore.score) {
                let newTestScore = TestScore(context: self.dataController.context)
                newTestScore.score = score
                newTestScore.date = Date()
                studentScore.student.addToScores(newTestScore)
            }
        }
        
        dataController.saveData()
        dismiss()
        
    }
    
    func nextStudent() {
        if (self.numStudents == self.studentIndex + 1) {
            self.saveStudents()
            return
        }
        
        self.studentIndex += 1
    }
    
    func previousStudent() {
        if (self.studentIndex == 0) {
            return
        }
        
        self.studentIndex -= 1
    }
    
    
}

struct AddTest: View {
    @ObservedObject var viewModel: AddTestViewModel
    
    init(withStudents students: [Student], dataController: DataController) {
        self.viewModel = AddTestViewModel(students: students, dataController: dataController)
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                AddTestStudent(current: viewModel.current)
                
                Spacer()
                
                HStack(alignment: .center) {
                    
                    GeometryReader { geo in
                        Button {
                            viewModel.previousStudent()
                        } label: {
                            Text("Previous")
                                .padding()
                                .frame(width: geo.size.width)
                                .background(Color.secondary)
                                .cornerRadius(8)
                                .foregroundColor(.black)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .disabled(viewModel.isFirst)
                    }
                    
                    GeometryReader { geo in
                        Button {
                            viewModel.nextStudent()
                        } label: {
                            Text(viewModel.isLast ? "Submit" : "Next")
                                .padding()
                                .frame(width: geo.size.width)
                                .background(Color.blue)
                                .cornerRadius(8)
                                .foregroundColor(.black)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    
                }
            }
            .padding()
            .frame(minWidth: 250, maxWidth: .infinity, minHeight: 250, maxHeight: .infinity)
            .navigationTitle("Add Test Score")
        }
        
    }
}

private class TextFieldObserver: NSObject {
    @objc
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.selectAll(nil)
    }
}

struct AddTestStudent: View {
    @ObservedObject var current: StudentWithScore
    private let textFieldObserver = TextFieldObserver()
    
    init(current: StudentWithScore) {
        self.current = current
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(current.student.fullName)
                .font(.headline)
            TextField(
                "Score",
                text: $current.score
            )
            .shadow(radius: 4)
            .introspectTextField { textField in
                textField.addTarget(
                    self.textFieldObserver,
                    action: #selector(TextFieldObserver.textFieldDidBeginEditing),
                    for: .editingDidBegin
                )
            }
            .keyboardType(.numberPad)
        }
    }
    
}



//struct AddTest_Previews: PreviewProvider {
//    static var previews: some View {
//        AddTest()
//    }
//}
