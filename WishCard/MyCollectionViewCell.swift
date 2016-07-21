//
//  MyCollectionViewCell.swift
//  Lozi5
//
//  Created by AnhLtv on 5/1/16.
//  Copyright © 2016 SummerLab. All rights reserved.
//

import UIKit

class MyCollectionViewCell: UICollectionViewCell {
    var img:UIImageView!
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        img = UIImageView(frame: frame)
        self.addSubview(img)
    }
}
