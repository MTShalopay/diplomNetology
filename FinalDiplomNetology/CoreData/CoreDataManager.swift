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
    func createUser(numberPhone: String?, password: Int16?, firstName: String?, secondName: String?, dayBirth: String?, city: String?, profession: String?, complition: ((String?)-> Void)?) {
        persistentContainer.performBackgroundTask { (context) in
            let user = User(context: context)
            user.uuID = UUID().uuidString
            user.city = city
            user.dayBirth = dayBirth
            user.firstName = firstName
            user.secondName = secondName
            user.numberPhone = numberPhone
            user.password = password ?? 0
            user.profession = profession
            do {
                try context.save()
                complition?(user.uuID)
            } catch let error {
                print(error)
                complition?(nil)
            }
        }
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
    func getUser(by uuid: String) {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "uuID == %@", uuid)
        do {
            if let user = (try context.fetch(fetchRequest)).first {
                print(user.uuID)
            }
        } catch let error {
            print(error)
        }
        /*
         fetchRequest.predicate = NSPredicate(format: "author contains[c] %@", argumentArray: [authorName])
         do {
             let posts = try persistentContainer.viewContext.fetch(fetchRequest) as! [FavoriteItem]
             return posts
         } catch {
             print("ERROR SEARCHPOST \(error)")
             return []
         }
         */
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
    
    func deleteAll() {
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
