//
//  AddStudentView.swift
//  Progress
//
//  Created by Noah Johnson on 4/10/22.
//

import SwiftUI

struct AddStudentView: View {
    @ObservedObject var classVM: ClassViewModel
    @Environment(\.dismiss) var dismiss
    
    @State private var firstName = ""
    @State private var lastName = ""
    
    var body: some View {
        Form {
            Section {
                TextField("First Name", text: $firstName)
                TextField("Last Name", text: $lastName)
            }
            
            Section {
                Button("Save") {
                    classVM.addStudent(firstName: firstName, lastName: lastName)
                    
                    dismiss()
                }
            }
        }
    }
}

struct AddStudentView_Previews: PreviewProvider {
    static let classVM = ClassViewModel()
    
    static var previews: some View {
        AddStudentView(classVM: classVM)
    }
}
