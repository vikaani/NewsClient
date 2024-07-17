//
//  ManagedSavedArticle.swift
//  NewsClient
//
//  Created by Vika on 08.07.2024.
//
//

import CoreData

@objc(ManagedSavedArticle)
public class ManagedSavedArticle: NSManagedObject {
    @NSManaged public var title: String
    @NSManaged public var articleDescription: String
    @NSManaged public var url: URL
    @NSManaged public var imageData: Data?
    @NSManaged public var publishedAt: Date
    @NSManaged public var id: UUID
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<ManagedSavedArticle> {
        return NSFetchRequest<ManagedSavedArticle>(entityName: "ManagedSavedArticle")
    }
}
