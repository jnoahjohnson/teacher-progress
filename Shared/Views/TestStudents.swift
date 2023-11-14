//
//  TestStudents.swift
//  Progress (iOS)
//
//  Created by Noah Johnson on 7/2/22.
//

import SwiftUI

class StudentRowViewModel: ObservableObject, Identifiable {
    let student: Student
    let name: String
    @Published var score: String = "0"
    
    init(student: Student) {
        self.name = student.fullName
        self.student = student
    }
}

class TestStudentsViewModel: ObservableObject {
    let dataController = DataController.shared
    @Published var students: [StudentRowViewModel]
    
    init(students: [Student]) {
        var newStudents: [StudentRowViewModel] = []
        
        students.forEach { student in
            let newStudent = StudentRowViewModel(student: student)
            newStudents.append(newStudent)
        }
        
        self.students = newStudents
    }
    
    func saveScores() {
        students.forEach { student in
            dataController.addScoreToStudent(student: student.student, score: Int(student.score) ?? 0)
        }
    }
}

struct TestStudents: View {
    @ObservedObject var viewModel: TestStudentsViewModel
    @Environment(\.dismiss) private var dismiss
    
    @FocusState private var focusedField: String?
    
    @State private var currentStudent = 0 {
        willSet {
            if viewModel.students.count > 0 {
                focusedField = viewModel.students[newValue].name
            }
        }
    }
    
    init(with viewModel: TestStudentsViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    VStack {
                        ForEach(viewModel.students) { student in
                            HStack {
                                Text(student.name)
                                    .font(.title3)
                                Spacer()
                                TextField("", text: Binding(get: {student.score}, set: { student.score = $0 }))
                                    .multilineTextAlignment(.center)
                                    .frame(width: 32.0)
                                    .background(
                                        VStack {
                                            Spacer()
                                            Color.primary
                                                .frame(height: 1)
                                        }
                                    )
                                    .onReceive(NotificationCenter.default.publisher(for: UITextField.textDidBeginEditingNotification)) { obj in
                                        if let textField = obj.object as? UITextField {
                                            textField.selectedTextRange = textField.textRange(from: textField.beginningOfDocument, to: textField.endOfDocument)
                                        }
                                    }
                                    .keyboardType(.decimalPad)
                                    .focused($focusedField, equals: student.name)
                            }
                        }
                    }
                    .padding()
                }
                .onAppear {
                    currentStudent = 0
                }
            }
            
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Button("Previous") {
                        currentStudent -= 1
                    }
                    .disabled(currentStudent == 0)
                    
                    if (currentStudent == viewModel.students.count - 1) {
                        Button("Save") {
                            viewModel.saveScores()
                            dismiss()
                        }
    
                    } else {
                        Button("Next") {
                            currentStudent += 1
                        }
                        .disabled(currentStudent == viewModel.students.count - 1)
                    }
                }
            }
        }
        
    }
}

//struct TestStudents_Previews: PreviewProvider {
//    static var previews: some View {
//        TestStudents(with: TestStudentsViewModel(students: [Student()]))
//    }
//}
