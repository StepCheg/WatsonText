//
//  ViewController.swift
//  WatsonTest
//
//  Created by Stepan Chegrenev on 30/11/2018.
//  Copyright © 2018 Stepan Chegrenev. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextViewDelegate {
    
    @IBOutlet weak var detectingView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var translateButton: UIButton!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var selectLanguageButton: UIButton!
    
    @IBOutlet weak var selectedLanguageLabel: UILabel!
    @IBOutlet weak var selectLanguageHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var selectLanguageView: UIView!
    var numberOfRowsForPickerView: Array<String>?
    let vcModel = ViewControllerModel.sharedInstance
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.delegate = self
        pickerView.dataSource = self
        textView.delegate = self
        activityIndicator.startAnimating()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if ((numberOfRowsForPickerView) != nil)
        {
            
            if (textView.text == "")
            {
                detectingView.isHidden = false
                return 0
            }
            
            return (numberOfRowsForPickerView?.count)!
        }
        else
        {
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        if (numberOfRowsForPickerView != nil)
        {
            if (textView.text == "")
            {
                detectingView.isHidden = false
                return "English"
            }
            
            return numberOfRowsForPickerView![row]
        }
        else
        {
            return "English"
        }
    }
    
    func textViewDidChange(_ textView: UITextView)
    {
        selectedLanguageLabel.text = "No language is selected"
        
        if (selectLanguageHeightConstraint.constant == 208)
        {
            selectLanguageHeightConstraint.constant = 46
            translateButton.setTitle("Translate", for: .normal)
            selectLanguageButton.setTitle("Select Language", for: .normal)
        }
        
        
        
    }
    
    @IBAction func translateAction(_ sender: UIButton)
    {
        
        if (selectLanguageHeightConstraint.constant == 208)
        {
                if (numberOfRowsForPickerView![pickerView.selectedRow(inComponent: 0)] != "This language is not supported")
                {
                    selectLanguageHeightConstraint.constant = 46
                    translateButton.setTitle("Translate", for: .normal)
                    selectLanguageButton.setTitle("Select Language", for: .normal)
                    selectedLanguageLabel.text = numberOfRowsForPickerView![pickerView.selectedRow(inComponent: 0)]
                    
                }
                else
                {
                    showAlertWithText(text: "This language is not supported")
                }
        }
        else
        {
//            if ((textView.text.count > 0) && (numberOfRowsForPickerView![pickerView.selectedRow(inComponent: 0)] != "This language is not supported"))
//            {
            let reachability = Reachability()!
            if (reachability.connection == .none)
            {
                self.showAlertWithText(text: "Network not reachable")
            }
            else
            {
                if (self.selectedLanguageLabel.text != "No language is selected")
                {
                    
                    translateButton.isUserInteractionEnabled = false
                    
                    let timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { (timer) in
                        
                        timer.invalidate()
                        self.translateButton.isUserInteractionEnabled = true
                    }
//                        Timer.init(timeInterval: 3, repeats: false) { _ in
//                        self.translateButton.isUserInteractionEnabled = true
//                    }
                    
                    let targetLanguage = self.numberOfRowsForPickerView![self.pickerView.selectedRow(inComponent: 0)]
                    let text = self.textView.text
                    
                    self.vcModel.getLang(fromText: self.textView.text, success: { (resultLang) in
                        
                        self.vcModel.translateAction(text: text!, sourceLanguage: resultLang, targetLanguage: self.vcModel.getTargetLanguage(lang: targetLanguage), success: { (resultString) in
                            
                            let translatedResult = TranslatedResultModel(originalText: text!, sourceLanguage: resultLang, translatedText: resultString, targetLanguage: self.vcModel.getTargetLanguage(lang: targetLanguage))
                            
//                            NotificationCenter.default.post(NSNotification.Name(rawValue: "newTranslatedResult"))
                            
                                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "newTranslatedResult"), object: nil, userInfo: nil)
                            DispatchQueue.main.async
                                {
                                    self.performSegue(withIdentifier: "DetailViewControllerSegue", sender: translatedResult)
                            }
                        }) { (error) in
                            self.showAlertWithText(text: error)
                            print(error)
                        }
                    }) { (error) in
                        print(error)
                        self.showAlertWithText(text: error)
                    }
                }
                else
                {
                    self.showAlertWithText(text: "No language is selected")
                }
            }
        }
    }
    
    func showAlertWithText(text: String) {
        let alertController = UIAlertController(title: "Attention!", message: text, preferredStyle: .alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func openSelectLanguageView(_ sender: UIButton)
    {
        if (selectLanguageHeightConstraint.constant == 46)
        {
            if (textView.text.count != 0)
            {
                let reachability = Reachability()!
                if (reachability.connection == .none)
                {
                    self.showAlertWithText(text: "Network not reachable")
                }
                else
                {
                    self.detectingView.isHidden = false
                    
                    self.vcModel.setupPickerView(text: self.textView.text, success: { (resultArray) in
                        self.numberOfRowsForPickerView = resultArray
                        DispatchQueue.main.async {
                            self.detectingView.isHidden = true
                            self.pickerView.reloadAllComponents()
                        }
                    }) { (error) in
                        self.showAlertWithText(text: error)
                    }
                    
                    self.selectLanguageHeightConstraint.constant = 208
                    self.selectLanguageButton.setTitle("Cancel", for: .normal)
                    self.translateButton.setTitle("Select", for: .normal)
                }
            }
            else
            {
                showAlertWithText(text: "No text was entered")
            }
        }
        else
        {
            selectLanguageHeightConstraint.constant = 46
            translateButton.setTitle("Translate", for: .normal)
            selectLanguageButton.setTitle("Select Language", for: .normal)
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "DetailViewControllerSegue")
        {
            let destVC = segue.destination as! DetailViewController
            let senderObject = sender as! TranslatedResultModel
            
            destVC.originalText = senderObject.originalText
            destVC.sourceLanguage = senderObject.sourceLanguage
            destVC.translatedText = senderObject.translatedText
            destVC.targetLanguage = senderObject.targetLanguage
        }
    }
    
    @objc func dismissKeyboard() {
        
        view.endEditing(true)
    }
}
