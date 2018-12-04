//
//  PickerViewModel.swift
//  WatsonTest
//
//  Created by Stepan Chegrenev on 01/12/2018.
//  Copyright © 2018 Stepan Chegrenev. All rights reserved.
//

import Foundation

class PickerViewModel
{
    
    let supportedLanguages: Array<String>!
    let language: String!
    let languageDict = ["Arabic" : "ar", "Czech" : "cs", "Danish" : "da", "Dutch" : "nl",
                        "Finnish" : "fi", "Hindi" : "hi", "Hungarian" : "hu", "Japanese" : "ja",
                        "Korean" : "ko", "Norwegian Bokmal" : "nb", "Polish" : "pl", "Portuguese" : "pt",
                        "Russian" : "ru", "Simplified Chinese" : "zh", "Swedish" : "sv", "Traditional Chinese" : "zh-TW",
                        "Turkish" : "tr", "English" : "en", "Catalan" : "ca", "Spanish" : "es",
                        "French" : "fr", "German" : "ge", "Italian" : "it"]
    
    init(lang: String) {
        
        language = lang
        
        let arrayForEngLang = ["ar", "cs", "da", "nl", "fi",
                               "hi", "hu", "ja", "ko", "nb",
                               "pl", "pt", "ru", "zh", "sv",
                               "zh-TW", "tr"]
        
        if (arrayForEngLang.contains(lang))
        {
            supportedLanguages = ["English"]
        }
        else if (lang == "ca")
        {
            supportedLanguages = ["Spanish"]
        }
        else if (lang == "en")
        {
            supportedLanguages = ["Arabic", "Czech", "Danish", "Dutch", "Finnish",
                           "French", "German", "Hindi", "Hungarian", "Italian",
                           "Japanese", "Korean", "Norwegian Bokmal", "Polish", "Portuguese",
                           "Russian", "Simplified Chinese", "Spanish", "Swedish", "Traditional Chinese",
                           "Turkish"]
        }
        else if (lang == "fr")
        {
            supportedLanguages = ["English", "German", "Spanish"]
        }
        else if (lang == "ge")
        {
            supportedLanguages = ["Italian", "English", "French"]
        }
        else if (lang == "it")
        {
            supportedLanguages = ["English", "German"]
        }
        else if (lang == "es")
        {
            supportedLanguages = ["Catalan", "English", "French"]
        }
        else
        {
            supportedLanguages = ["This language is not supported"]
        }
    }
}
