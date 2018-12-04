//
//  TableViewController.swift
//  WatsonTest
//
//  Created by Stepan Chegrenev on 30/11/2018.
//  Copyright © 2018 Stepan Chegrenev. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController
{
    
    
    
    var arrayOfTranslatedResults: [TranslatedResult]?
    let vcModel = TableViewControllerModel()

    override func viewDidLoad()
    {
        super.viewDidLoad()

        arrayOfTranslatedResults = [TranslatedResult]()
        
        NotificationCenter.default.addObserver(self, selector: #selector(addObjectInTableView), name: NSNotification.Name(rawValue: "newTranslatedResult"), object: nil)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        setupTableView()
    }
    
    func setupTableView() {
        
        
        arrayOfTranslatedResults = vcModel.getArrayOfAllTranslatedResults()
        
        tableView.reloadData()
    }

    @objc func addObjectInTableView()
    {
        let translatedResult = vcModel.getNewTranslatedResult()
        
        arrayOfTranslatedResults?.insert(translatedResult, at: 0)
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return arrayOfTranslatedResults!.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        
        cell.sourceLanguageLabel.text = arrayOfTranslatedResults![indexPath.row].sourceLanguage
        cell.originalTextLabel.text = arrayOfTranslatedResults![indexPath.row].originalText
        cell.targetLanguageLabel.text = arrayOfTranslatedResults![indexPath.row].targetLamguage
        cell.translatedTextLabel.text = arrayOfTranslatedResults![indexPath.row].translatedText
        
        // Configure the cell...

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
