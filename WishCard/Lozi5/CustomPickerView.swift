//
//  CustomPickerView.swift
//  Lozi5
//
//  Created by AnhLtv on 4/28/16.
//  Copyright © 2016 SummerLab. All rights reserved.
//

import UIKit

class CustomPickerView: UIView ,UIPickerViewDataSource, UIPickerViewDelegate{
    var pickerView:UIPickerView!
    let pickerFontFamily = UIFont.familyNames()
    let pickerFontSize = ["10","15","18","20","26","28","36","48","72"]
    var pickerData = []
    var index = -1
    enum PickerComponent:Int {
        case size = 0
        case fontname = 1
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
    }
    init(frame: CGRect,type: Int) {
        super.init(frame: frame)
        pickerView = UIPickerView(frame: frame)
        if type == 1
        {
            pickerData = [pickerFontSize, pickerFontFamily]
            pickerView.selectRow(2, inComponent: PickerComponent.size.rawValue, animated: false)
            updateContent()
            index = 1
            
        }
        else if type == 2
        {
            pickerData = [["animal","bg","dog","emotion","hand","other"]];
            pickerView.selectRow(1, inComponent: 0 , animated: false)
            updateContent()
            index = 2
            
        }
        pickerView.delegate = self
        pickerView.dataSource = self
        self.addSubview(pickerView)
        
    }
    func updateContent()
    {
        if index == 1
        {
            let sizeComponent = PickerComponent.size.rawValue
            let fontNameComponent = PickerComponent.fontname.rawValue
            let size:String = (pickerData[sizeComponent] as! NSArray)[pickerView.selectedRowInComponent(sizeComponent)] as! String
            ImageWishViewController.fontSize = Int.init(size)
            let fontname = (pickerData[fontNameComponent] as! NSArray)[pickerView.selectedRowInComponent(fontNameComponent)] as! String
            ImageWishViewController.fontName = fontname
            
        }
        else if index == 2
        {
            let typeIcon:String = (pickerData[0] as! NSArray)[pickerView.selectedRowInComponent(0)] as! String
            ImageWishViewController.iconType = typeIcon
            
        }
        
        
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        updateContent()
        
    }
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int
    {
        return pickerData.count
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return pickerData[component].count
    }
    
    func pickerView(pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString?
    {
        let str = (pickerData[component] as! NSArray)[row]
        return NSAttributedString(string: str as! String, attributes: [NSForegroundColorAttributeName:UIColor.blueColor()])
    }
    
    
}
