//
//  NetworkManager.swift
//  WatsonTest
//
//  Created by Stepan Chegrenev on 30/11/2018.
//  Copyright © 2018 Stepan Chegrenev. All rights reserved.
//

import Foundation

class NetworkManager
{

    static let sharedInstance = NetworkManager()
    
    public enum ApiMethod: String {
        case IdentifableLanguage = "api/v3/identifiable_languages?version=2018-12-01"
        case Identify = "api/v3/identify?version=2018-12-01"
        case Translate = "api/v3/translate?version=2018-12-01"
    }
    
    let userName = "6987a48d-342e-4a69-8adc-e65b1cc0b9da"
    let password = "MxYSIi6nQP2Y"
    let urlString = "https://gateway.watsonplatform.net/language-translator/"
    
    func getAuthString() -> String {
        let loginString = String(format: "%@:%@", userName, password)
        let loginData = loginString.data(using: String.Encoding.utf8)!
        return loginData.base64EncodedString()
    }
    
    
    func networkFunc(urlStr: String, params: [String:String],contenType: String,  success: @escaping ((Any) -> Void), failure: @escaping ((String) -> Void))
    {
        
        let authString = getAuthString()
        
        var request = URLRequest(url: URL(string: urlStr)!)
        request.httpMethod = "POST"
        request.setValue("Basic \(authString)", forHTTPHeaderField: "Authorization")
        request.addValue(contenType, forHTTPHeaderField: "Content-Type")
        let session = URLSession.shared
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: params, options: []) else { return }
        request.httpBody = httpBody
        
        session.dataTask(with: request) { (data, response, error) in
            
            guard let data = data else { return }
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                
                success(json)
                
            } catch {
                print(error)
                failure(error as! String)
            }
            }.resume()
    }
    
    func getLanguage(fromText: String, success: @escaping ((String) -> Void), failure: @escaping ((String) -> Void)) {
        
        let urlStr = urlString + ApiMethod.Identify.rawValue
        
        let params = ["text": fromText]
        networkFunc(urlStr: urlStr, params: params, contenType: "text/plain", success: { (json) in
            
            let arr = (json as! Dictionary<String, Any>)["languages"]
            let dict = (arr as! Array<Any>)[0]
            
            let lang = (dict as! Dictionary<String, Any>)["language"] as! String
            
            success(lang)
            
        }) { (error) in
            failure(error)
        }
    }
    
    func translate(text: String, sourceLanguage: String, targetLanguage: String, success: @escaping ((String) -> Void), failure: @escaping ((String) -> Void))
    {
        
        let urlStr = urlString + ApiMethod.Translate.rawValue
        
        let params = ["text": text, "source": sourceLanguage, "target": targetLanguage]
        networkFunc(urlStr: urlStr, params: params, contenType: "application/json", success: { (json) in
            
            let arr = (json as! Dictionary<String, Any>)["translations"]
            let dict = (arr as! Array<Any>)[0]
            
            let result = (dict as! Dictionary<String, Any>)["translation"]
            success(result as! String)
            
        }) { (error) in
            failure(error)
        }
        
        
    }
    
    
    
}
