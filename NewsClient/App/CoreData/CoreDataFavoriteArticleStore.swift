//
//  CoreDataSavedArticleStore.swift
//  NewsClient
//
//  Created by Vika on 24.06.2024.
//

import CoreData

final class CoreDataFavoriteArticleStore {
    private let persistanceContainer: NSPersistentContainer
    
    init() {
        persistanceContainer = NSPersistentContainer(name: "SavedArticleStore")
        persistanceContainer.loadPersistentStores { _, error in
            if let error {
                print(error.localizedDescription)
            }
        }
    }
}

extension CoreDataFavoriteArticleStore: FavoriteArticleLoaderStore {
    func save(_ article: FavoriteArticle) throws {
        let managedSavedArticle = ManagedSavedArticle(context: persistanceContainer.viewContext)
        managedSavedArticle.title = article.title
        managedSavedArticle.articleDescription = article.description
        managedSavedArticle.url = article.url
        managedSavedArticle.imageData = article.imageData
        managedSavedArticle.publishedAt = article.publishedAt
        managedSavedArticle.id = article.id
        try persistanceContainer.viewContext.save()
    }
    
    func removeArticle(byID id: UUID) throws {
        let request = ManagedSavedArticle.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id.uuidString)
        let managedSavedArticle = try persistanceContainer.viewContext.fetch(request)
        guard let firstManagedSavedArticle = managedSavedArticle.first else { return }
        persistanceContainer.viewContext.delete(firstManagedSavedArticle)
        try persistanceContainer.viewContext.save()
    }
    
    func retrieve() throws -> [FavoriteArticle] {
        let request = ManagedSavedArticle.fetchRequest()
        
        let articles = try persistanceContainer.viewContext.fetch(request)
        
        return articles.map { article in
            FavoriteArticle(
                id: article.id,
                title: article.title,
                description: article.description,
                url: article.url,
                imageData: article.imageData,
                publishedAt: article.publishedAt
            )
        }
    }
}
