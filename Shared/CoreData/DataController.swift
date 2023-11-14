//
//  DataConroller.swift
//  Bookworm
//
//  Created by Noah Johnson on 3/21/22.
//

import CoreData
import SwiftUI

class DataController: ObservableObject {
    static let shared = DataController()
    
    let container = NSPersistentContainer(name: "ProgressStudents")
    
    @Published var students: [Student] = []
    
    var context: NSManagedObjectContext {
        self.container.viewContext
    }
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core data failed to load: \(error.localizedDescription)")
            }
        }
        
        self.fetchStudents()
    }
    
    func fetchStudents() {
        let request = NSFetchRequest<Student>(entityName: "Student")
        
        do {
            let fetchedStudents = try context.fetch(request)
            self.students = fetchedStudents
        } catch let error {
            print("Error fetching \(error)")
        }
    }
    
    func saveData() {
        do {
            try context.save()
            fetchStudents()
            
        } catch let error {
            print("Error saving. \(error)")
        }
    }
    
    func addStudent(firstName: String, lastName: String) {
        let newStudent = Student(context: self.context)
        newStudent.firstName = firstName
        newStudent.lastName = lastName
        
        self.saveData()
    }
    
    func deleteStudent(at offsets: IndexSet) {
        for offset in offsets {
            // find this student in our fetch request
            let student = self.students[offset]
            
            // delete it from the context
            self.context.delete(student)
        }
        
        // save the context
        self.saveData()
    }
    
    func seedData() {
        resetAllRecords(in: "TestScore")
        resetAllRecords(in: "Student")
        
        let today = Date()
        let day = 86400
        
        let student1 = Student(context: context)
        student1.firstName = "Beckham"
        student1.lastName = "Johnson"
        
        let test11 = TestScore(context: context)
        test11.date = Date(timeIntervalSince1970: today.timeIntervalSince1970 - Double((day * 10)))
        test11.score = 25
        student1.addToScores(test11)
        
        let test12 = TestScore(context: context)
        test12.date = Date(timeIntervalSince1970: today.timeIntervalSince1970 - Double((day * 5)))
        test12.score = 45
        student1.addToScores(test12)
        
        let student2 = Student(context: context)
        student2.firstName = "Korin"
        student2.lastName = "Johnson"
        
        let test21 = TestScore(context: context)
        test21.date = Date(timeIntervalSince1970: today.timeIntervalSince1970 - Double((day * 10)))
        test21.score = 45
        student2.addToScores(test21)
        
        let test22 = TestScore(context: context)
        test22.date = Date(timeIntervalSince1970: today.timeIntervalSince1970 - Double((day * 5)))
        test22.score = 45
        student2.addToScores(test22)
        
        let test23 = TestScore(context: context)
        test23.date = Date()
        test23.score = 100
        student2.addToScores(test23)
        
        print(student1.scoresArray, student2.scoresArray)
        
        saveData()
        
    }
    
    func resetAllRecords(in entity : String) {
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        do
        {
            try context.execute(deleteRequest)
            try context.save()
        }
        catch
        {
            print ("There was an error")
        }
    }
    
    func addScoreToStudent(student: Student, score: Int) {
        let newScore = TestScore(context: self.context)
        newScore.score = Int16(score)
        newScore.date = Date()
        newScore.student = student
        
        self.saveData()
    }
}
