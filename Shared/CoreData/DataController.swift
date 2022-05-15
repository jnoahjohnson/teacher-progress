//
//  DataConroller.swift
//  Bookworm
//
//  Created by Noah Johnson on 3/21/22.
//

import CoreData
import SwiftUI

class DataController: ObservableObject {
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
    
}
