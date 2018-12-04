//
//  TableViewControllerModel.swift
//  WatsonTest
//
//  Created by Stepan Chegrenev on 30/11/2018.
//  Copyright © 2018 Stepan Chegrenev. All rights reserved.
//

import Foundation

class TableViewControllerModel
{
    static let sharedInstance = TableViewControllerModel()
    
    var arrayOfTranslatedResults = [TranslatedResult]()
    
    let dataManager = CoreDataManager()
    
    func getArrayOfAllTranslatedResults() -> [TranslatedResult]
    {
        arrayOfTranslatedResults = dataManager.getData()
        
        return arrayOfTranslatedResults
    }
    
    func getNewTranslatedResult() -> TranslatedResult
    {
        let translatedResult = dataManager.getLastObject()
        
        if (arrayOfTranslatedResults[0] != translatedResult)
        {
            arrayOfTranslatedResults.insert(translatedResult!, at: 0)
        }
        
        
        return translatedResult!
    }

}
