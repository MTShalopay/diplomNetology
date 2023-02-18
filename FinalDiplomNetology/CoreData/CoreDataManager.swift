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
    /*
//    MARK: fetchRequest CoreData
//    var jokes: [Joke] {
//        let fetchRequest: NSFetchRequest<Joke> = Joke.fetchRequest()
//        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "dateCreate", ascending: false)]
//        return (try? persistentContainer.viewContext.fetch(fetchRequest)) ?? []
//    }
//
//    func createJoke(from JokeCodable: JokeCodable, completionHandler: ((_ error: String?)->Void)? ) {
//        persistentContainer.performBackgroundTask { (context) in
//            let joke = Joke(context: context)
//            joke.uid = JokeCodable.id
//            joke.text = JokeCodable.value
//            joke.dateCreate = Date()
//            do {
//                try context.save()
//                completionHandler?(nil)
//            } catch {
//                print("ERROR create Joke: \(error.localizedDescription)")
//                completionHandler?("Joke ERROR: \(error.localizedDescription)")
//            }
//        }
//    }
    */
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
    
    func chekcduplicateUser(for numberPhone: String) -> Bool {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        fetchRequest.predicate = NSPredicate(format: "numberPhone == %@",numberPhone)
        do {
            let result = try persistentContainer.viewContext.fetch(fetchRequest) as! [User]
            if result.count == 0 {
                return true
            }
            
        } catch let error {
            print("chekcduplicateUser ERROR: \(error)")
        }
        return false
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
    
    /*
     func checkDuplicate(authorName: String) -> Bool {
         let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteItem")
         fetchRequest.predicate = NSPredicate(format: "author == %@", argumentArray: [authorName])
         let count = try! persistentContainer.viewContext.count(for: fetchRequest)
         fetchRequest.fetchLimit = count
         guard count == 0 else {
             print("POST DUBLICATE")
                 return false
         }
         return true
     }
     */
    /*
     let fetchrequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
     fetchrequest.predicate = NSPredicate(format: "numberPhone == %@", "89275403646")
     do {
         let result = try coreDataManager.context.fetch(fetchrequest)
         for user in result as! [User] {
             print("uuID :\(user.uuID) phone: \(user.numberPhone)")
         }
         
     } catch let error {
         print(error)
     }
     print("============")
     */
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
    
//    func createJoke(from JokeCodable: JokeCodable) {
//        persistentContainer.performBackgroundTask { (context) in
//            let joke = Joke(context: context)
//            joke.uid = JokeCodable.id
//            joke.text = JokeCodable.value
//            joke.dateCreate = Date()
//            JokeCodable.categories.forEach { (category) in
//                let categoryJoke = self.getCategory(by: category, contex: context)
//                joke.addToCategories(categoryJoke)
//            }
//            do {
//                try context.save()
//            } catch {
//                print("ERROR create Joke: \(error.localizedDescription)")
//            }
//        }
//    }
    func getUser(by uuid: String) -> User {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "uuID == %@", uuid)
        do {
            if let user = (try context.fetch(fetchRequest)).first {
                //print(user.uuID, user.numberPhone)
                return user
            }
        } catch let error {
            print(error)
        }
        return User()
    }
//    func getCategory(by name: String, contex: NSManagedObjectContext) -> Categories {
//        let request: NSFetchRequest<Categories> = Categories.fetchRequest()
//        request.predicate = NSPredicate(format: "name == %@", name)
//            if let category = (try? contex.fetch(request).first) {
//                return category
//            } else {
//                let newCategory = Categories(context: contex)
//                newCategory.name = name
//                return newCategory
//            }
//    }
    
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
//    func deleteCategory(category: Categories) {
//        category.jokes?.forEach({ (joke) in
//            deleteJoke(joke: joke as! Joke)
//        })
//        persistentContainer.viewContext.delete(category)
//        saveContext()
//    }
}
