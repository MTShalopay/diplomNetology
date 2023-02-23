//
//  CoreDataManager.swift
//  FinalDiplomNetology
//
//  Created by Shalopay on 06.01.2023.
//

import Foundation
import CoreData
class CoreDataManager {
    static let shared = CoreDataManager()
    
    private init() {}
    
    lazy var context: NSManagedObjectContext = {
        persistentContainer.viewContext
    }()
    
    //Описание сущности
    func entityForName(_ name: String) -> NSEntityDescription{
        return NSEntityDescription.entity(forEntityName: name, in: context)!
    }
    
    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "FinalDiplomNetology")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
        return container
    }()
    
    // MARK: - Core Data Saving support
    func saveContext () {
        print("Сохранение данных")
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    func fetchChekNumberPhone(for numberPhone: String, comletion: ((User?) -> Void)?) -> Bool {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName:"User")
        request.predicate = NSPredicate(format: "numberPhone == %@", numberPhone)
        do {
            let result = try persistentContainer.viewContext.fetch(request) as! [User]
            if result.count == 0 {
                comletion?(nil)
                return false
            }
            comletion?(result.first)
        } catch let error {
            print("fetchRequest error: \(error) ")
        }
        return true
    }
    
    func verificationUserPassword(password: String) -> Bool {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        fetchRequest.predicate = NSPredicate(format: "password == %@",password)
        do {
            let result = try persistentContainer.viewContext.fetch(fetchRequest) as! [User]
            if result.count != 0 {
                return false
            }
        } catch let error {
            print("chekcduplicateUser ERROR: \(error)")
        }
        return true
    }
    
    func getUser() {
        guard let currentUserUID = currentUserUID else { return }
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        fetchRequest.predicate = NSPredicate(format: "uuID == %@", currentUserUID)
        do {
            let result = try persistentContainer.viewContext.fetch(fetchRequest).first as! User
            CurrentUser = result
        } catch let error {
            print("ERROR: \(error)")
        }
    }
    
    func chekcUser(for numberPhone: String, completion: ((User?)-> Void)?) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        fetchRequest.predicate = NSPredicate(format: "numberPhone == %@",numberPhone)
        do {
            let result = try persistentContainer.viewContext.fetch(fetchRequest) as! [User]
            if result.count == 0 {
                completion?(nil)
                return
            }
            completion?(result.first)
        } catch let error {
            print("chekcduplicateUser ERROR: \(error)")
        }
        
    }
    
    func fetchChekPassword(_ password: String) -> Bool {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName:"User")
        request.predicate = NSPredicate(format: "password == %@", password)
        do {
            let result = try persistentContainer.viewContext.fetch(request) as! [User]
            if result.count == 0 {
                return true
            }
        } catch let error {
            print("fetchRequest error: \(error) ")
        }
        return false
    }
    
    func createUser() -> User {
        let user = NSManagedObject(entity: entityForName("User"), insertInto: context) as! User
        user.uuID = UUID().uuidString
        saveContext()
        return user
    }
    
    func createPost(image: Data?, text: String?) -> Post {
        let post = NSManagedObject(entity: entityForName("Post"), insertInto: context) as! Post
        post.date = Date()
        post.favorite = false
        post.image = image
        post.text = text
        saveContext()
        return post
    }
    
    func createPhoto(imageData: Data) -> Photo {
        let photo = NSManagedObject(entity: entityForName("Photo"), insertInto: context) as! Photo
        photo.date = Date()
        photo.image = imageData
        saveContext()
        return photo
    }
    
    func createStories(storiesData: Data) -> Stories {
        let stories = NSManagedObject(entity: entityForName("Stories"), insertInto: context) as! Stories
        stories.date = Date()
        stories.image = storiesData
        saveContext()
        return stories
    }

    func deleteUser(user: User) {
        persistentContainer.viewContext.delete(user)
        saveContext()
        print("Удалили юзера с телефоном \(user.numberPhone)")
    }
    
    func deletePost(post: Post) {
        persistentContainer.viewContext.delete(post)
        saveContext()
        print("Удалили пост")
    }
    
    func deletePhoto(photo: Photo) {
        persistentContainer.viewContext.delete(photo)
        saveContext()
        print("Удалили фотографию")
    }
    
    func deleteAllPhoto() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Photo")
        do {
            let results = try context.fetch(fetchRequest) as! [Photo]
            for result in results {
                context.delete(result)
                saveContext()
            }
        } catch let error {
            print(error)
        }
        print("Удалили все фотографии")
    }
    
    func deleteAllUser() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        do {
            let results = try context.fetch(fetchRequest) as! [User]
            for result in results {
                context.delete(result)
                saveContext()
            }
        } catch let error {
            print(error)
        }
        print("Удалили всех юзеров")
    }
    
    func deleteAllFollowers() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        do {
            let users = try context.fetch(fetchRequest) as! [User]
            for user in users {
                for follower in user.followers!.allObjects as! [User] {
                    context.delete(follower)
                    saveContext()
                }
            }
        } catch let error {
            print(error)
        }
        print("Удалили всех подписчиков")
    }
}
