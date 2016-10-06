//
//  AlertView.swift
//  CustomAlertView
//
//  Created by ben ziv on 8/19/15.
//  Copyright (c) 2015 BZGames. All rights reserved.
//

import UIKit

enum BUTTONS_COUNT{
    //You Can add as many as you want...
    
    case ONE, TWO
}

class AlertView:UIView ,UITextViewDelegate{
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    var alertTextView = UITextView()
    var colorpicker = HSBColorPicker()
    var collectionView:CollectionImageView!
    var fontView:CustomPickerView!
    var imageGalleryView = UIImageView()
    
    //this alert view isnt rounded...
    //now i will explain a bit on the content size
    //ill show image that explain on it... now lets test it
    
    init(frame: CGRect, alertText:String, buttons_count:BUTTONS_COUNT, buttons_text:[String], actions_name:[String], target: AnyObject?) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.blackColor()
       // let a = NSTextContainer(size: CGSizeMake()
       // alertTextView = EditableUILabel(frame: frame, textContainer: <#T##NSTextContainer?#>)
        //i like to start 20 pixels from the top and from the left sid4
        
        alertTextView.frame =  CGRect(x: 0, y: 0, width: frame.width , height: (frame.height / 6) * 5 )
        
    
        alertTextView.text = alertText
        alertTextView.textColor = UIColor.blackColor()
        alertTextView.backgroundColor = UIColor.whiteColor()
        alertTextView.font = UIFont(name: /*<Font Name>*/ "Heiti SC", size: /*Size*/ CGFloat(16))
        alertTextView.scrollEnabled = true // if you have lot of text you should do it... and you think that it will go out of bounds...
        alertTextView.editable = true
        alertTextView.selectable = true
        alertTextView.contentSize = CGSize(width: alertTextView.frame.width, height: alertTextView.frame.height) //it isnt a scroll tutorial but ill explain on it later :)
        alertTextView.delegate = self
        let newPosition = alertTextView.endOfDocument
        alertTextView.selectedTextRange = alertTextView.textRangeFromPosition(newPosition, toPosition: newPosition)
        
        
        
        self.addSubview(alertTextView)
        
        switch(buttons_count){
        case .ONE:
            let button = UIButton(frame: CGRect(x: 0, y: (frame.height / 6) * 5, width: frame.width, height: frame.height / 6))
            button.setTitle(buttons_text[0], forState: UIControlState.Normal)
            button.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
            button.backgroundColor = UIColor.grayColor()
            button.titleLabel?.font = UIFont(name: /*<Font Name>*/ "Heiti SC", size: /*Size*/ CGFloat(14))
            button.addTarget(target, action: Selector(actions_name[0]), forControlEvents: UIControlEvents.TouchUpInside)
            
            self.addSubview(button)
            break
        case .TWO:
            let button = UIButton(frame: CGRect(x: 0, y: (frame.height / 6) * 5, width: frame.width / 2-1, height: frame.height / 6))
            button.setTitle(buttons_text[0], forState: .Normal)
            button.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
            button.backgroundColor = UIColor(red: 26.0/255.0, green: 132.0/255.0, blue: 70.0/255.0, alpha:1.0)
            button.titleLabel?.font = UIFont(name: /*<Font Name>*/ "Heiti SC", size: /*Size*/ CGFloat(14))
            button.addTarget(target, action: Selector(actions_name[0]), forControlEvents: UIControlEvents.TouchUpInside)
            
            self.addSubview(button)
            
            let button_2 = UIButton(frame: CGRect(x: frame.width / 2+1, y: (frame.height / 6) * 5, width: frame.width / 2, height: frame.height / 6))
            button_2.setTitle(buttons_text[1], forState: UIControlState.Normal)
            button_2.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
            button_2.backgroundColor = UIColor(red: 26.0/255.0, green: 132.0/255.0, blue: 70.0/255.0, alpha:1.0)
            button_2.titleLabel?.font = UIFont(name: /*<Font Name>*/ "Heiti SC", size: /*Size*/ CGFloat(14))
            button_2.addTarget(target, action: Selector(actions_name[1]), forControlEvents: UIControlEvents.TouchUpInside)
            
            self.addSubview(button_2)
            
            break
        }
    }
    init(frame: CGRect, buttons_count:BUTTONS_COUNT, buttons_text:[String], actions_name:[String], target: AnyObject?) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.blackColor()
        colorpicker = HSBColorPicker( frame: CGRect(x: 0, y: 0, width: frame.width , height: (frame.height / 6) * 5 ))
        self.addSubview(colorpicker)
        
        self.addSubview(alertTextView) // sorry :/ if i made lot of mistakes
        
        switch(buttons_count){
        case .ONE:
            let button = UIButton(frame: CGRect(x: 0, y: (frame.height / 6) * 5, width: frame.width, height: frame.height / 6))
            button.setTitle(buttons_text[0], forState: UIControlState.Normal)
            button.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
            button.backgroundColor = UIColor.grayColor()
            button.titleLabel?.font = UIFont(name: /*<Font Name>*/ "Heiti SC", size: /*Size*/ CGFloat(14))
            button.addTarget(target, action: Selector(actions_name[0]), forControlEvents: UIControlEvents.TouchUpInside)
            
            self.addSubview(button)
            break
        case .TWO:
            let button = UIButton(frame: CGRect(x: 0, y: (frame.height / 6) * 5, width: frame.width / 2-1, height: frame.height / 6))
            button.setTitle(buttons_text[0], forState: .Normal)
            button.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
            button.backgroundColor = UIColor(red: 26.0/255.0, green: 132.0/255.0, blue: 70.0/255.0, alpha:1.0)
            button.titleLabel?.font = UIFont(name: /*<Font Name>*/ "Heiti SC", size: /*Size*/ CGFloat(14))
            button.addTarget(target, action: Selector(actions_name[0]), forControlEvents: UIControlEvents.TouchUpInside)
            
            self.addSubview(button)
            
            let button_2 = UIButton(frame: CGRect(x: frame.width / 2+1, y: (frame.height / 6) * 5, width: frame.width / 2, height: frame.height / 6))
            button_2.setTitle(buttons_text[1], forState: UIControlState.Normal)
            button_2.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
            button_2.backgroundColor = UIColor(red: 26.0/255.0, green: 132.0/255.0, blue: 70.0/255.0, alpha:1.0)
            button_2.titleLabel?.font = UIFont(name: /*<Font Name>*/ "Heiti SC", size: /*Size*/ CGFloat(14))
            button_2.addTarget(target, action: Selector(actions_name[1]), forControlEvents: UIControlEvents.TouchUpInside)
            
            self.addSubview(button_2)
            
            break
        }
    }
    
    init(frame: CGRect, buttons_count:BUTTONS_COUNT, buttons_text:[String], actions_name:[String], target: AnyObject?,idAleart:Int) {
        super.init(frame: frame)
        
        
        var rate:CGFloat = 5/6
        var divide:CGFloat = 6
        if(idAleart == 1)
        {
            rate = 7/8
            divide = 8
            collectionView = CollectionImageView(frame: CGRect(x: 0, y: 0, width: frame.width , height: frame.height*rate ), folderName: "Collection")
            self.backgroundColor = UIColor.blackColor()
            self.addSubview(collectionView)
        }
            
        else if(idAleart == 2)
        {
            self.backgroundColor = UIColor.clearColor()
            fontView = CustomPickerView(frame: CGRect(x: 0, y: 0, width: frame.width , height: (frame.height / 6) * 5 ),type: 1)
            self.addSubview(fontView)
            
        }
        else if(idAleart == 3)
        {
            self.backgroundColor = UIColor.clearColor()
            fontView = CustomPickerView(frame: CGRect(x: 0, y: 0, width: frame.width , height: (frame.height / 6) * 5 ),type: 2)
            self.addSubview(fontView)
            
        }
        else if(idAleart == 4)
        {
            self.backgroundColor = UIColor(red: 54.0/255.0, green: 152.0/255.0, blue: 102.0/255.0, alpha:1.0)
            imageGalleryView = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.width , height: (frame.height / 6) * 5 ))
            if imageGallery == nil
            {
                imageGalleryView.image = UIImage(named: "pic")
            }
            else
            {
                imageGalleryView.image = UIImage(contentsOfFile: imageGallery)
                
            }
            self.addSubview(imageGalleryView)
            
        }
        
        
        switch(buttons_count){
        case .ONE:
            let button = UIButton(frame: CGRect(x: 0, y: (frame.height / 6) * 5, width: frame.width, height: frame.height / 6))
            button.setTitle(buttons_text[0], forState: UIControlState.Normal)
            button.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
            button.backgroundColor = UIColor.grayColor()
            button.titleLabel?.font = UIFont(name: /*<Font Name>*/ "Heiti SC", size: /*Size*/ CGFloat(14))
            button.addTarget(target, action: Selector(actions_name[0]), forControlEvents: UIControlEvents.TouchUpInside)
            
            self.addSubview(button)
            break
        case .TWO:
            let button = UIButton(frame: CGRect(x: 0, y: frame.height*rate , width: frame.width / 2-1, height: frame.height / divide))
            button.setTitle(buttons_text[0], forState: .Normal)
            button.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
            button.backgroundColor = UIColor(red: 26.0/255.0, green: 132.0/255.0, blue: 70.0/255.0, alpha:1.0)
            button.titleLabel?.font = UIFont(name: /*<Font Name>*/ "Heiti SC", size: /*Size*/ CGFloat(14))
            button.addTarget(target, action: Selector(actions_name[0]), forControlEvents: UIControlEvents.TouchUpInside)
            
            self.addSubview(button)
            
            let button_2 = UIButton(frame: CGRect(x: frame.width / 2+1, y: frame.height*rate, width: frame.width / 2, height: frame.height / divide))
            button_2.setTitle(buttons_text[1], forState: UIControlState.Normal)
            button_2.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
            button_2.backgroundColor = UIColor(red: 26.0/255.0, green: 132.0/255.0, blue: 70.0/255.0, alpha:1.0)
            button_2.titleLabel?.font = UIFont(name: /*<Font Name>*/ "Heiti SC", size: /*Size*/ CGFloat(14))
            button_2.addTarget(target, action: Selector(actions_name[1]), forControlEvents: UIControlEvents.TouchUpInside)
            
            self.addSubview(button_2)
            
            break
        }
    }
    func reloadData()
    {
        imageGalleryView.image = UIImage(contentsOfFile: imageGallery)
    }
    func textViewShouldBeginEditing(textView: UITextView) -> Bool {
       
        
        
        return true
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.endEditing(true)
        
    }
    func textViewShouldEndEditing(textView: UITextView) -> Bool {
        textView.resignFirstResponder()
    
        
        return true
    }
    func textViewDidChange(textView: UITextView) {
       
      
    }

    
    
}
