//
//  DatabaseHelper.swift
//  Nikita_MyORDER
//
//  Created by Никита on 27.03.2021.
//

import Foundation
import CoreData
import UIKit

class DatabaseHelper{
    
    private static var shared : DatabaseHelper?
    
    static func getInstance() -> DatabaseHelper{
        if shared != nil{
            return shared!
        }else{
            return DatabaseHelper(context: (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext)
        }
    }
    
    private let moc : NSManagedObjectContext
    private let ENTITY_NAME = "Order"
    private init (context : NSManagedObjectContext){
        self.moc = context
    }
    
    func updateTask(updatedTask: Order){
        let searchResult = self.searchTask(taskID: updatedTask.id! as UUID)
        
        if (searchResult != nil){
            do{
                let taskToUpdate = searchResult!
                
                /*taskToUpdate.title = updatedTask.title
                taskToUpdate.subtitle = updatedTask.subtitle
                taskToUpdate.completion = updatedTask.completion
                */
                try self.moc.save()
                print(#function, "Task updated successfully")
                
            }catch let error as NSError{
                print(#function, "Unable to search task \(error)")
            }
        }
    }
    
    func searchTask(taskID : UUID) -> Order?{
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: ENTITY_NAME)
        let predicateID = NSPredicate(format: "id == %@", taskID as CVarArg)
        fetchRequest.predicate = predicateID
        
        do{
            
            let result = try self.moc.fetch(fetchRequest)
            
            if result.count > 0{
                return result.first as? Order
            }
            
        }catch let error as NSError{
            print("Unable to search task \(error)")
        }
        
        return nil
    }
    
    func deleteTask(taskID : UUID)  {
        let searchResult = self.searchTask(taskID: taskID)
        
        if (searchResult != nil){
            //matching record found
            do{
                
                self.moc.delete(searchResult!)
//                try self.moc.save()
                
                let delegate = UIApplication.shared.delegate as! AppDelegate
                delegate.saveContext()
                
                print(#function, "Task deleted successfully")
                
            }catch let error as NSError{
                print("Unable to delete task \(error)")
            }
        }
    }
    
    //retrieve all orders
    func getAllOrders() -> [Order]?{
        let fetchRequest = NSFetchRequest<Order>(entityName: ENTITY_NAME)
        fetchRequest.sortDescriptors = [NSSortDescriptor.init(key: "id", ascending: false)]
        do{
            let result = try self.moc.fetch(fetchRequest)
            return result as [Order]
        }catch let error as NSError{
            print("Could not fetch data \(error) \(error.code)")
        }
        
        return nil
    }
}
