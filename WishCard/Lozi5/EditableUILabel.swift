//
//  EditableUILabel.swift
//  Lozi5
//
//  Created by Phan Van Hoc on 7/19/16.
//  Copyright © 2016 SummerLab. All rights reserved.
//

import UIKit

class EditableUILabel: UITextView {
    
    override func canBecomeFirstResponder() -> Bool {
        return true
    }
    func shareInit()
    {
        userInteractionEnabled = true
    }
    override func paste(sender: AnyObject?) {
        self.text = UIPasteboard.generalPasteboard().string
        
    }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
