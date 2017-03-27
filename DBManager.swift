//
//  DBManager.swift
//  agendaDummy
//
//  Created by Jerry on 3/21/17.
//  Copyright © 2017 Jerry. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class DBManager {
    
    
    
    /*declaracion del sigleton*/
    static let instance = DBManager()
    
    func encuentraTodosLos (nombreEntidad: String, ordenadoPor: String) -> NSArray {
        let elQuery:NSFetchRequest = NSFetchRequest()
        
        let laEntidad:NSEntityDescription = NSEntityDescription.entityForName(nombreEntidad, inManagedObjectContext: self.managedObjectContext!)!
        elQuery.entity = laEntidad //tabla
        
        do{
            let result = try self.managedObjectContext!.executeFetchRequest(elQuery)
            return result as NSArray
        }
        catch{
            print("Error al ejecutar")
            return NSArray()
        }
        
    }
    
    func encuentraTodosLos (nombreEntidad: String, filtradoPor: NSPredicate) -> NSArray{
        
        let elQuery:NSFetchRequest = NSFetchRequest()
        
        let laEntidad:NSEntityDescription = NSEntityDescription.entityForName(nombreEntidad, inManagedObjectContext: self.managedObjectContext!)!
        
        elQuery.entity = laEntidad // tabla
        elQuery.predicate = filtradoPor // clusula where
        
        
        do{
            let result = try self.managedObjectContext!.executeFetchRequest(elQuery)
            return result as NSArray
        }
        catch{
            print("Error al ejecutar")
            return NSArray()
        }
    
    }
    
    lazy var managedObjectContext:NSManagedObjectContext? = {
        let persistence = self.persistStore
        
        if persistence == nil{
            return nil
        }
        
        var moc = NSManagedObjectContext(concurrencyType: .PrivateQueueConcurrencyType)
        moc.persistentStoreCoordinator = persistence
        
        return moc
        
        
    }()
    
    lazy var managedObjectModel:NSManagedObjectModel? = {
        
        let url = NSBundle.mainBundle().URLForResource("Model", withExtension: "momd") /*buscando archivo de modelado*/
        			
        var model = NSManagedObjectModel(contentsOfURL:url!)
        /*los archivos que se agregan al proyecto en tiempo de diseño quedan ubicados en resources y son de solo lectura*/
        
        return model
        
    }()
    
    lazy var persistStore: NSPersistentStoreCoordinator? = {
        let model = self.managedObjectModel
        
        if model == nil {
            return nil
        }
        
        let persist = NSPersistentStoreCoordinator(managedObjectModel:model!)
        
        /*Encontrar ubicacion de la BD*/
        let urldelaDB = self.directorioDocuments.URLByAppendingPathComponent("Model.sqlite")
        
        do{ /*el do se utiliza como parte del try catch*/
            let OpcionesDePersistencia = [NSMigratePersistentStoresAutomaticallyOption: true, NSInferMappingModelAutomaticallyOption: true]
            
            try persist.addPersistentStoreWithType (NSSQLiteStoreType, configuration:nil, URL:urldelaDB, options:OpcionesDePersistencia)
        }
        catch{
            print("no se puede abrir la base de datos")
            abort() // terminar ejecucion de la app
            
        }
        
        
        return persist
        
    }()
    
    lazy var directorioDocuments:NSURL = {
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        
        return urls[urls.count-1]
        
    }()
    
    
    
    
}

