//
//  JournalEntry+CoreDataProperties.swift
//  Appy2
//
//  Created by Amber Craig on 23/02/2023.
//
//

import Foundation
import CoreData


extension JournalEntry {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<JournalEntry> {
        return NSFetchRequest<JournalEntry>(entityName: "JournalEntry")
    }

    @NSManaged public var entry: String?
    @NSManaged public var date: Date?

}

extension JournalEntry : Identifiable {

    func setMonth() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM"
        if let dateToBeModified = date {
            let month = formatter.string(from: dateToBeModified)
            return month
        }
        return ""
    }
    
    func setDay() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        if let dateToBeModified = date {
            let day = formatter.string(from: dateToBeModified)
            return day.uppercased()
        }
        return ""
    }
}
