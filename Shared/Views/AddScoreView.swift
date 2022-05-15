//
//  AddScoreView.swift
//  Progress
//
//  Created by Noah Johnson on 4/10/22.
//

import SwiftUI

struct AddScoreView: View {
    @EnvironmentObject var dataController: DataController
    @Environment(\.dismiss) var dismiss
    var student: Student
    
    @State private var score = 0
    
    var body: some View {
        NavigationView {
            
            
            Form {
                Section("Score") {
                    TextField("Score", value: $score, formatter: NumberFormatter())
                        .keyboardType(.numberPad)
                }
                
                Section {
                    Button("Save") {
                        let newScore = TestScore(context: dataController.context)
                        newScore.score = Int16(score)
                        newScore.date = Date()
                        newScore.student = student
                        
                        dataController.saveData()
                        
                        dismiss()
                    }
                }
                
            }
        }
    }
}

//struct AddScoreView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddScoreView()
//    }
//}
