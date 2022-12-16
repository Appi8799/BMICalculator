//
//  Data+CoreDataProperties.swift
//  FinalTest_MAPD714_ApekshaParmar_301205325
//
//  Created by Apeksha Parmar on 2022-12-16.
//
//

import Foundation
import CoreData


extension Data {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Data> {
        return NSFetchRequest<Data>(entityName: "Data")
    }

    @NSManaged public var addedDate: String?
    @NSManaged public var age: String?
    @NSManaged public var date: Date?
    @NSManaged public var height: String?
    @NSManaged public var id: Int32
    @NSManaged public var name: String?
    @NSManaged public var score: String?
    @NSManaged public var weight: String?

}

extension Data : Identifiable {

}
