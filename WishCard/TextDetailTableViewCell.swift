//
//  TextDetailTableViewCell.swift
//  Lozi5
//
//  Created by AnhLtv on 4/13/16.
//  Copyright © 2016 SummerLab. All rights reserved.
//

import UIKit

class TextDetailTableViewCell: UITableViewCell {
    
    @IBOutlet var txtContent: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor(red: 54.0/255.0, green: 152.0/255.0, blue: 102.0/255.0, alpha:1.0)
        txtContent.textColor = UIColor(red: 54.0/255.0, green: 152.0/255.0, blue: 102.0/255.0, alpha:1.0)
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
