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
    
    //retrieve all orders
    func getAllOrders() -> [Order]?{
        let fetchRequest = NSFetchRequest<Order>(entityName: ENTITY_NAME)
        fetchRequest.sortDescriptors = [NSSortDescriptor.init(key: "id", ascending: true)]
        do{
            let result = try self.moc.fetch(fetchRequest)
            return result as [Order]
        }catch let error as NSError{
            print("Could not fetch data \(error) \(error.code)")
        }
        
        return nil
    }
}
