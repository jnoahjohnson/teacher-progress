//
//  StudentViewModel.swift
//  Progress (iOS)
//
//  Created by Noah Johnson on 6/11/22.
//

import Foundation
import Combine

class StudentViewModel: ObservableObject, Identifiable {
    let dataController = DataController.shared
    @Published var student: Student
    
    var id: Int = 0
    
    private var cancellables = Set<AnyCancellable>()
    
    
    init(student: Student) {
        self.student = student
        
        $student
            .map{ $0.id.hashValue }
            .assign(to: \.id, on: self)
            .store(in: &cancellables)
    }
    
    func addScore(_ score: Int) {
        dataController.addScoreToStudent(student: self.student, score: score)
    }
}
