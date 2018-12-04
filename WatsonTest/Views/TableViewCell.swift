//
//  TableViewCell.swift
//  WatsonTest
//
//  Created by Stepan Chegrenev on 04/12/2018.
//  Copyright © 2018 Stepan Chegrenev. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var sourceLanguageLabel: UILabel!
    @IBOutlet weak var originalTextLabel: UILabel!
    
    @IBOutlet weak var targetLanguageLabel: UILabel!
    @IBOutlet weak var translatedTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
