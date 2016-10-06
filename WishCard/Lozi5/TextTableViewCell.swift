//
//  TextTableViewCell.swift
//  Lozi5
//
//  Created by AnhLtv on 4/10/16.
//  Copyright © 2016 SummerLab. All rights reserved.
//

import UIKit

class TextTableViewCell: UITableViewCell {
    
    @IBOutlet var avarImg: UIImageView!
    
    @IBOutlet var customCell: UIView!
    @IBOutlet var btnNext: UIImageView!
    @IBOutlet var avarText: UILabel!
    override func awakeFromNib() {
        customCell.backgroundColor = UIColor.whiteColor()
        
        customCell.layer.cornerRadius = 11.0
        self.layer.masksToBounds = true
        // Initialization code
        
    }
    override func setHighlighted(highlighted: Bool, animated: Bool) {
        if(highlighted)
        {
            customCell.backgroundColor = UIColor(red: 124.0/255.0, green: 152.0/255.0, blue: 102.0/255.0, alpha:1.0)
        }
        else
        {customCell.backgroundColor = UIColor(red: 54.0/255.0, green: 152.0/255.0, blue: 102.0/255.0, alpha:1.0)
            
        }
    }
    

    
}
