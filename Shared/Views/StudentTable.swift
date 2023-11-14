//
//  StudentTable.swift
//  Progress (iOS)
//
//  Created by Noah Johnson on 6/11/22.
//

import SwiftUI

struct StudentTable: View {
    
    let students: [Student] = []
    
    var body: some View {
        Table {
            TableColumn("Student Name") { student in
                if UIDevice.current.userInterfaceIdiom == .phone {
                    VStack(alignment: .leading) {
                        Text(student.fullName)
                            .font(.headline)
                        
                        HStack() {
                            Text(student.timeSinceLastAssessment)
                            Text(student.lastTestScore)
                        }
                    }
                } else {
                    Text(student.fullName)
                }
                
            }
            
            TableColumn("Since Last") { student in
                Text(student.timeSinceLastAssessment)
            }
            
            TableColumn("Last Score") {student in
                Text(student.lastTestScore)
            }
            
        } rows: {
            ForEach(students) { student in
                TableRow(student)
            }
        }
        .padding()
    }
}

struct StudentTable_Previews: PreviewProvider {
    static var previews: some View {
        StudentTable()
    }
}
