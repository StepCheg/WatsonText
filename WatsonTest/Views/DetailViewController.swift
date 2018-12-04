//
//  DetailViewController.swift
//  WatsonTest
//
//  Created by Stepan Chegrenev on 02/12/2018.
//  Copyright © 2018 Stepan Chegrenev. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    
    var originalText: String?
    var sourceLanguage: String?
    var translatedText: String?
    var targetLanguage: String?
    
    @IBOutlet weak var sourceLanguageLabel: UILabel!
    
    @IBOutlet weak var originalTextLabel: UILabel!
    
    @IBOutlet weak var targetLanguageLabel: UILabel!
    
    @IBOutlet weak var translatedTextLabel: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        sourceLanguageLabel.text = sourceLanguage!
        originalTextLabel.text = originalText!
        targetLanguageLabel.text = targetLanguage!
        translatedTextLabel.text = translatedText!
        
        // Do any additional setup after loading the view.
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
