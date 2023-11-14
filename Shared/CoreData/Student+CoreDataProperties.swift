//
//  Student+CoreDataProperties.swift
//  Progress
//
//  Created by Noah Johnson on 4/10/22.
//
//

import Foundation
import CoreData


extension Student {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Student> {
        return NSFetchRequest<Student>(entityName: "Student")
    }

    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?
    @NSManaged public var scores: NSSet?
    
    var fullName: String {
        return "\(self.firstName ?? "First") \(self.lastName ?? "Last")"
    }
    
    var scoresArray: [TestScore] {
        let set = scores as? Set<TestScore> ?? []
        
        return set.sorted {
            $0.wrappedDate < $1.wrappedDate
        }
    }
    
    var recentTestDate: Date? {
        return scoresArray.last?.date
    }
    
    var lastTestScore: String {
        if let score = scoresArray.last?.score {
            return String(score)
        } else {
            return "N/A"
        }
    }
    
    var timeSinceLastAssessment: String {
        if let assessmentDate = recentTestDate {
            let cal = Calendar.current
            let today = cal.startOfDay(for: Date())
            let previousAssessment = cal.startOfDay(for: assessmentDate)
            let diff = cal.dateComponents([.day], from: previousAssessment, to: today)
            
            if (diff.day! == 0) {
                return "Today 🎉"
            }
            
            return diff.day! > 1 ? "\(diff.day!) days ago" : "1 day ago"
        } else {
            return "No Test Scores"
        }
    }
}

// MARK: Generated accessors for scores
extension Student {

    @objc(addScoresObject:)
    @NSManaged public func addToScores(_ value: TestScore)

    @objc(removeScoresObject:)
    @NSManaged public func removeFromScores(_ value: TestScore)

    @objc(addScores:)
    @NSManaged public func addToScores(_ values: NSSet)

    @objc(removeScores:)
    @NSManaged public func removeFromScores(_ values: NSSet)

}

extension Student : Identifiable {

}
