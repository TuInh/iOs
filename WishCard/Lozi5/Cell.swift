//
//  Cell.swift
//  Lozi5
//
//  Created by Tu Inh Le on 5/1/16.
//  Copyright © 2016 SummerLab. All rights reserved.
//
import UIKit


class Cell: UICollectionViewCell {
    
    var img:UIImageView!
     override init(frame: CGRect) {
       super.init(frame: frame)
    
        img = UIImageView(frame: CGRectMake(0, 0, frame.width, frame.height))
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
