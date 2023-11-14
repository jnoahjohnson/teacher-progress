//
//  ClassViewModel.swift
//  Progress (iOS)
//
//  Created by Noah Johnson on 6/11/22.
//

import Foundation
import Combine

struct MonthAverageScore {
    var score: Int
    var month: String
}

class ClassViewModel: ObservableObject {
    let dataController = DataController.shared
    
    @Published var studentViewModels: [StudentViewModel] = [] {
        didSet {
            self.graphData = self.getClassAveragesByMonth(numMonths: 12)
        }
    }
    @Published var graphData: [MonthAverageScore] = []
    @Published var filteredMonth: Month? = nil
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        self.studentViewModels = []
        
        dataController.$students.map { students in
            students.map { student in
                StudentViewModel(student: student)
            }
        }
        .assign(to: \.studentViewModels, on: self)
        .store(in: &cancellables)
    }
    
    func seedData() {
        dataController.seedData()
    }
    
    func deleteStudent(at offsets: IndexSet) {
        self.dataController.deleteStudent(at: offsets)
    }
    
    func addStudent(firstName: String, lastName: String) {
        self.dataController.addStudent(firstName: firstName, lastName: lastName)
    }
    
    func getAllStudents() -> [Student] {
        return self.dataController.students
    }
    
    func getClassAverage() -> Int {
        var testScoresSum = 0
        var testScoresCount = 0
        
        dataController.students.forEach { student in
            student.scoresArray.forEach { score in
                testScoresCount += 1
                testScoresSum += Int(score.score)
            }
        }
        
        if (testScoresCount == 0) {
            return 0
        }
        
        return testScoresSum / testScoresCount
    }
    
    // Filter by each day
    
    func getMonthClassAverage(month: String) -> Int {
        var testScoresCount = 0
        var testScoresSum = 0
        
        dataController.students.forEach { student in
            student.scoresArray.forEach { score in
                if (month == score.wrappedDate.monthName()) {
                    testScoresCount += 1
                    testScoresSum += Int(score.score)
                }
            }
        }
        
        if (testScoresCount == 0) {
            return 0
        }

        return testScoresSum / testScoresCount
    }
    
    func getClassAveragesByMonth(numMonths: Int) -> [MonthAverageScore] {
        
        var scores: [MonthAverageScore] = []
        
        for month in Month.allCases {
            let score = getMonthClassAverage(month: month.rawValue)
            
            scores.append(MonthAverageScore(score: score, month: month.rawValue))
        }
        
        print("Scores", scores)
        
        return scores
    }
}
