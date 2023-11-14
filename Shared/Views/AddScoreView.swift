//
//  AddScoreView.swift
//  Progress
//
//  Created by Noah Johnson on 4/10/22.
//

import SwiftUI

struct AddScoreView: View {
    var onSave: (_ score: Int) -> Void
    
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
                        self.onSave(score)
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
