//
//  CoreDataManager.swift
//  WatsonTest
//
//  Created by Stepan Chegrenev on 02/12/2018.
//  Copyright © 2018 Stepan Chegrenev. All rights reserved.
//

import UIKit
import CoreData

class CoreDataManager {
    
    var appDelegate: AppDelegate!
    var context: NSManagedObjectContext!
    var fetchRequest: NSFetchRequest<NSFetchRequestResult>!
    
    init() {
        DispatchQueue.main.async {
            self.appDelegate = (UIApplication.shared.delegate as! AppDelegate)
            self.context = self.appDelegate.persistentContainer.viewContext
            self.fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "TranslatedResult")
        }
    }
    
    func saveData(originalText: String, sourceLanguage: String, targetLanguage: String, translatedText: String) {

//        DispatchQueue.main.sync {
//            self.appDelegate = (UIApplication.shared.delegate as! AppDelegate)
//            self.context = self.appDelegate.persistentContainer.viewContext
//            self.postRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "TranslatedResult")
//        }
        let translatedResult = TranslatedResult(context: context)
        translatedResult.originalText = originalText
        translatedResult.sourceLanguage = sourceLanguage
        translatedResult.targetLamguage = targetLanguage
        translatedResult.translatedText = translatedText
    
//    func saveData(translatedResult: TranslatedResultModel) {
//        
//        
//        context.setValue(translatedResult.originalText, forKeyPath: "originalText")
//        context.setValue(translatedResult.sourceLanguage, forKeyPath: "sourceLanguage")
//        context.setValue(translatedResult.targetLanguage, forKeyPath: "targetLamguage")
//        context.setValue(translatedResult.translatedText, forKeyPath: "translatedText")
        
        
        
        do
        {
            try context.save()
            print("Data saving")
        }
        catch
        {
            //PROCESS ERROR
            print("Failed saving")
        }
    }
    
    func getData() -> [TranslatedResult] {
        
        fetchRequest.returnsObjectsAsFaults = false
        
        var arrayOfTranslatedResults = [TranslatedResult]()
        
        do
        {
            let results = try context.fetch(fetchRequest)
            
            if results.count > 0
            {
//                for index in (results.count - 1)...0  {
//                    let result = (results as! [NSManagedObject])[index]
//                    arrayOfTranslatedResults.append(result as! TranslatedResult)
//                }
                
                for result in results as! [NSManagedObject]
                {
                    let translatedResult = result as! TranslatedResult

                    arrayOfTranslatedResults.insert(translatedResult, at: 0)
                }
            }
        }
        catch
        {
            // PROCESS ERROR
        }
        
//        var tempArray = [TranslatedResult]()
        
        
        
        return arrayOfTranslatedResults
    }
    
    func getLastObject() -> TranslatedResult? {
//        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "momentTimeStamp", ascending: false)]
//        fetchRequest.fetchLimit = 1
//        fetchRequest.returnsObjectsAsFaults = false
        
        var returnObject: TranslatedResult!
        
//        .countForFetchRequest(fetchRequest, error: nil)
        
        
        guard let allElementsCount = try? context.count(for: fetchRequest) else {
            
            return nil
        }
        
        fetchRequest.fetchLimit = 1
        fetchRequest.fetchOffset = allElementsCount - 1
        fetchRequest.returnsObjectsAsFaults = false
    
        do
        {
            let results = try context.fetch(fetchRequest)
            
            if results.count > 0
            {
                for result in results as! [NSManagedObject]
                {
                    returnObject = result as? TranslatedResult
                }
            }
        }
        catch
        {
            // PROCESS ERROR
        }
        
        return returnObject
    }
}
