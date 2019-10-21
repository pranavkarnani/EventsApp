//
//  DataHandler.swift
//  App-A-Thon
//
//  Created by Pranav Karnani on 01/02/18.
//  Copyright © 2018 Pranav Karnani. All rights reserved.
//
import UIKit
import Foundation
import CoreData
import FirebaseDatabase

class DataHandler {
    
    static let shared: DataHandler = DataHandler()
    
    func cacheUserData(completion : @escaping (Bool) -> ())
    {
        DispatchQueue.main.async {
            
            let delegate = UIApplication.shared.delegate as! AppDelegate
            let context = delegate.persistentContainer.viewContext
            
            let entity = NSEntityDescription.insertNewObject(forEntityName: "UserDetails", into: context)
            
            if regNo.count == 9 {
                
                
                entity.setValue(regNo, forKey: "regNo")
                entity.setValue(true, forKey: "isLoggedIn")
                entity.setValue(wifiPassword, forKey: "wifiPassword")
                entity.setValue(wifiUsername, forKey: "wifiUsername")
                
                
                do {
                    try context.save()
                    completion(true)
                } catch {
                    print("error, caching user data")
                }
            }
        }
    }
    
    func retrieveData(completion : @escaping (Bool) -> ())
    {
        DispatchQueue.main.async {
            let delegate = UIApplication.shared.delegate as! AppDelegate
            let context = delegate.persistentContainer.viewContext
            
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "UserDetails")
            
            do {
                let results = try context.fetch(request)
                
                for result in results as! [NSManagedObject]
                {
                    regNo = result.value(forKey: "regNo") as? String ?? "N/A"
                    isLoggedIn = result.value(forKey: "isLoggedIn") as? Bool ?? false
                    wifiUsername = result.value(forKey: "wifiUsername") as? String ?? "N/A"
                    wifiPassword = result.value(forKey: "wifiPassword") as? String ?? "N/A"
                }
                
                completion(true)
                
            } catch {
                print("error, retrieving user data")
            }
        }
    }
    
    func deleteCachedData(completion : @escaping (Bool) -> ())
    {
        DispatchQueue.main.async {
            let delegate = UIApplication.shared.delegate as! AppDelegate
            let context = delegate.persistentContainer.viewContext
            
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "UserDetails")
            do
            {
                let results = try context.fetch(request)
                for result in results as! [NSManagedObject]
                {
                    context.delete(result)
                }
                try context.save()
                
                completion(true) 
            } catch
            {
                completion(false)
                print("error, deleting data")
            }
        }
    }
}
