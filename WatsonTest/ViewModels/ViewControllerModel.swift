//
//  ViewControllerModel.swift
//  WatsonTest
//
//  Created by Stepan Chegrenev on 30/11/2018.
//  Copyright © 2018 Stepan Chegrenev. All rights reserved.
//

import Foundation

class ViewControllerModel
{
    static let sharedInstance = ViewControllerModel()
    
    let networkManager = NetworkManager.sharedInstance
    let dataManager = CoreDataManager()
    var pickerViewModel: PickerViewModel?
    
    func setupPickerView(text: String, success: @escaping (Array<String>) -> Void, failure: @escaping (String) -> Void)
    {
        networkManager.getLanguage(fromText: text, success: { (resultString) in
            self.pickerViewModel = PickerViewModel(lang: resultString)
            success(self.pickerViewModel!.supportedLanguages)
        }) { (error) in
            failure(error)
//            print(error)
        }
        
    }
    
    func getTargetLanguage(lang: String) -> String {
        pickerViewModel = PickerViewModel.init(lang: lang)
        return pickerViewModel!.languageDict[lang]!
    }
    
    func translateAction(text: String, sourceLanguage: String, targetLanguage: String, success: @escaping (String) -> Void, failure: @escaping (String) -> Void)
    {
        networkManager.translate(text: text, sourceLanguage: sourceLanguage, targetLanguage: targetLanguage, success: { (resultString) in
            
            self.dataManager.saveData(originalText: text, sourceLanguage: sourceLanguage, targetLanguage: targetLanguage, translatedText: resultString)

            success(resultString)
            
        }) { (error) in
            failure(error)
        }
    }
    
    func getLang(fromText: String, success: @escaping ((String) -> Void), failure: @escaping ((String) -> Void)) {
        networkManager.getLanguage(fromText: fromText, success: { (resultString) in
            
            success(resultString)
            
        }) { (error) in
            failure(error)
        }
    }
    
    
    
}
