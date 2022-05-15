//
//  TestScore+CoreDataProperties.swift
//  Progress
//
//  Created by Noah Johnson on 4/10/22.
//
//

import Foundation
import CoreData


extension TestScore {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TestScore> {
        return NSFetchRequest<TestScore>(entityName: "TestScore")
    }

    @NSManaged public var score: Int16
    @NSManaged public var date: Date?
    @NSManaged public var student: Student?
    
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        let formattedDate = formatter.string(from: self.date ?? Date())
        print(formattedDate)
        
        return formattedDate
    }
    
    var wrappedDate: Date {
        date ?? Date.now
    }

}

extension TestScore : Identifiable {

}
