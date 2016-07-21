//
//  ImageWishViewController.swift
//  Lozi5
//
//  Created by AnhLtv on 4/17/16.
//  Copyright © 2016 SummerLab. All rights reserved.
//

import UIKit
import CoreData


class ImageWishViewController: UIViewController, UITextFieldDelegate {
    
    
    static var imageToShare:UIImage!
    static var mode:Int!
    static var pos:CGPoint = CGPoint()
    static var colorforText:UIColor!
    static var fontSize:Int!
    static var fontName:String!
    static var contentforText:String!
    static var iconType:String!
    static var isChangeBackground:Bool!
    static var previousMode = -1
    
    @IBOutlet var widthTodraw: NSLayoutConstraint!
    @IBOutlet var viewToDraw: UIView!
    @IBOutlet var tapGesture: UITapGestureRecognizer!
    @IBOutlet var height: NSLayoutConstraint!
    @IBOutlet var viewround: UIView!
    
    var aleartID = -1
    var sizeScreen = CGRect()
    
    // view for text
    var btnPickColor:UIButton = UIButton()
    var btnChooseImage:UIButton = UIButton()
    var btnChooseMode:UIButton = UIButton()
    var btnEraser:UIButton = UIButton()
    
    var textfieldIcon:UITextField = UITextField()
    var textfieldFont_Size:UITextField = UITextField()
    var textfieldContent:UITextField = UITextField()
    
    // view for icon
    
    
    // custom view for custom text
    var imageBackground:AlertView!
    var alertViewText:AlertView!
    var colorPicker:AlertView!
    var pickerFontView:AlertView!
    var pickerIconType:AlertView!
    var blurEffectView:UIVisualEffectView!
    var iconView:CollectionImageView!
    var folderName:String!
    
    @IBAction func ShareImagePressed(sender: AnyObject) {
        ImageWishViewController.previousMode = ImageWishViewController.mode
        ImageWishViewController.mode = 4
        viewToDraw.drawRect(CGRectMake(0, 0, 10, 10))
        if  ImageWishViewController.imageToShare == nil
        {
            print("null image to save")
        }
        else
        {
            let vc = UIActivityViewController(activityItems: [ImageWishViewController.imageToShare], applicationActivities: nil)
            self.presentViewController(vc, animated: true, completion: nil);
        }
        ImageWishViewController.mode = ImageWishViewController.previousMode
        
        // viewToDraw.drawRect(CGRectMake(0, 0, 10, 10))
        
    }
    @IBAction func SaveImagePressed(sender: AnyObject) {
        ImageWishViewController.previousMode = ImageWishViewController.mode
        ImageWishViewController.mode = 6
        viewToDraw.drawRect(CGRectMake(0, 0, 10, 10))
        ImageWishViewController.mode = ImageWishViewController.previousMode
        
        
        
        
        
        
    }
    
    @IBAction func NewImagePressed(sender: AnyObject) {
        
        ImageWishViewController.mode = 5
        pickerFontView.fontView.pickerView.selectRow(0, inComponent: 0, animated: false);
        pickerFontView.fontView.pickerView.selectRow(0, inComponent: 1, animated: false);
        
        ImageWishViewController.fontName = "Copperplate"
        ImageWishViewController.fontSize = 10
        textfieldFont_Size.text = "Copperplate     10 "
        
        imagePathBackground = NSBundle.mainBundle().resourcePath! + "/ImageWish/Collection/il_1.png" ;
        viewToDraw.drawRect(CGRectMake(0, 0, 10, 10))
        ImageWishViewController.contentforText = "Add your wish here"
        alertViewText.alertTextView.text = "Add your wish here"
        
        
        // fontName = "Copperplate"
        // fontSize = 10
        ImageWishViewController.iconType = "animal"
        ImageWishViewController.isChangeBackground = false
        ImageWishViewController.colorforText = UIColor.blackColor()
        btnPickColor.backgroundColor = UIColor.blackColor()
        btnChooseMode.setImage(UIImage(named: "textmode"), forState: .Normal)
        btnEraser.hidden = true
        textfieldIcon.hidden = true
        textfieldFont_Size.hidden = false
        textfieldContent.hidden = false
        btnPickColor.hidden = false
        iconView.hidden = true
        ImageWishViewController.mode = 1
        let request = NSFetchRequest(entityName: "ImageLink")
        request.returnsObjectsAsFaults = false
        do {
            let appDel:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let context:NSManagedObjectContext = appDel.managedObjectContext
            let results = try context.executeFetchRequest(request)
            
        }
        catch {
            print("Dim background error")
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ImageWishViewController.contentforText = "Add your wish here"
        ImageWishViewController.fontName = "Copperplate"
        ImageWishViewController.fontSize = 10
        ImageWishViewController.iconType = "animal"
        ImageWishViewController.isChangeBackground = false
        //viewToDraw = CustomDraw(coder: NSCoder)
        ImageWishViewController.colorforText = UIColor.blackColor()
        sizeScreen = UIScreen.mainScreen().bounds
        print("size round view \(viewround.frame.size)")
        self.view.backgroundColor = UIColor(red: 26.0/255.0, green: 132.0/255.0, blue: 70.0/255.0, alpha:1.0)
        viewround.backgroundColor = UIColor(red: 54.0/255.0, green: 152.0/255.0, blue: 102.0/255.0, alpha:1.0)
        viewToDraw.backgroundColor = UIColor.clearColor()
        // viewToDraw.frame = CGRectMake(0,0,size.width, size.height * 0.1)
        viewround.layer.cornerRadius = 11.0
        height.constant = sizeScreen.height * 0.6
        widthTodraw.constant = sizeScreen.width-16
        
        // Do any additional setup after loading the view.
        viewToDraw.userInteractionEnabled = true
        // UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(processTap:)];
        ImageWishViewController.mode = 1
        // create btn to Pick Color
        btnPickColor = UIButton.init(type: UIButtonType.Custom)
        btnPickColor.frame = CGRectMake(sizeScreen.width*0.75, sizeScreen.height*0.73 , sizeScreen.width*0.1, sizeScreen.width*0.1)
        btnPickColor.layer.cornerRadius = 0.5 * btnPickColor.bounds.size.width
        btnPickColor.backgroundColor = UIColor.blackColor()
        btnPickColor.addTarget(self, action: #selector(ImageWishViewController.thumbsUpButtonPressed), forControlEvents: .TouchUpInside)
        btnPickColor.hidden = false
        view.addSubview(btnPickColor)
        
        // create btn to choose background image
        btnChooseImage = UIButton.init(type: UIButtonType.Custom)
        btnChooseImage.frame = CGRectMake(sizeScreen.width*0.1, sizeScreen.height*0.81 , sizeScreen.width*0.1, sizeScreen.width*0.1)
        btnChooseImage.setImage(UIImage(named: "theme"), forState: .Normal)
        btnChooseImage.layer.cornerRadius = 0.5 * btnPickColor.bounds.size.width
        btnChooseImage.backgroundColor = UIColor.clearColor()
        btnChooseImage.addTarget(self, action: #selector(ImageWishViewController.chooseImageButtonPressed), forControlEvents: .TouchUpInside)
        view.addSubview(btnChooseImage)
        
        // create btn to choose beetwen icon or text field
        btnChooseMode = UIButton.init(type: UIButtonType.Custom)
        btnChooseMode.frame = CGRectMake(sizeScreen.width*0.25, sizeScreen.height*0.81 , sizeScreen.width*0.1, sizeScreen.width*0.1)
        btnChooseMode.setImage(UIImage(named: "textmode"), forState: .Normal)
        btnChooseMode.layer.cornerRadius = 0.5 * btnPickColor.bounds.size.width
        btnChooseMode.backgroundColor = UIColor.clearColor()
        btnChooseMode.addTarget(self, action: #selector(ImageWishViewController.chooseModeButtonPressed), forControlEvents: .TouchUpInside)
        
        view.addSubview(btnChooseMode)
        
        // create btn to erase icon
        // create btn to choose beetwen icon or text field
        btnEraser = UIButton.init(type: UIButtonType.Custom)
        btnEraser.frame = CGRectMake(sizeScreen.width*0.4, sizeScreen.height*0.81 , sizeScreen.width*0.1, sizeScreen.width*0.1)
        btnEraser.setImage(UIImage(named: "eraser_disable"), forState: .Normal)
        btnEraser.layer.cornerRadius = 0.5 * btnPickColor.bounds.size.width
        btnEraser.backgroundColor = UIColor.clearColor()
        btnEraser.addTarget(self, action: #selector(ImageWishViewController.eraseButtonPressed), forControlEvents: .TouchUpInside)
        btnEraser.hidden = true
        view.addSubview(btnEraser)
        
        
        
        // Add text content here
        textfieldContent.text = "Add your wish here"
        textfieldContent.textColor = UIColor.whiteColor()
        
        textfieldContent.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        textfieldContent.frame = CGRectMake(sizeScreen.width*0.1, sizeScreen.height*0.73 , sizeScreen.width*0.5, sizeScreen.width*0.1)
        
        self.textfieldContent.delegate = self
        
        let border = CALayer()
        let width = CGFloat(2.0)
        border.borderColor = UIColor.whiteColor().CGColor
        border.frame = CGRect(x: 0, y: textfieldContent.frame.size.height - width, width:  textfieldContent.frame.size.width, height: textfieldContent.frame.size.height)
        
        border.borderWidth = width
        textfieldContent.borderStyle = UITextBorderStyle.None
        textfieldContent.layer.addSublayer(border)
        textfieldContent.layer.masksToBounds = true
        textfieldContent.addTarget(self, action: #selector(ImageWishViewController.textFieldDidChange(_:)), forControlEvents: UIControlEvents.EditingDidBegin)
        //textfieldContent.hidden = true
        view.addSubview(textfieldContent)
        
        //
        folderName = "Sticker/"
        folderName = folderName + ImageWishViewController.iconType
        iconView = CollectionImageView(frame: CGRectMake(sizeScreen.width*0.1, sizeScreen.height*0.73, widthTodraw.constant - sizeScreen.width * 0.2 + 16, sizeScreen.width*0.1), folderName: folderName)
        iconView.hidden = true
        view.addSubview(iconView)
        
        
        //Choose font_size of text here
        textfieldFont_Size.text = "Copperplate     10 "
        textfieldFont_Size.textColor = UIColor.whiteColor()
        textfieldFont_Size.frame = CGRectMake(sizeScreen.width*0.5, sizeScreen.height*0.81 , sizeScreen.width*0.4, sizeScreen.width*0.07)
        self.textfieldFont_Size.delegate = self
        textfieldFont_Size.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        let dummyView:UIView = UIView.init(frame: CGRect(x: 0, y: textfieldFont_Size.frame.size.height - width, width:  textfieldFont_Size.frame.size.width, height: textfieldFont_Size.frame.size.height))
        textfieldFont_Size.inputView = dummyView // Hide keyboard, but show blinking cursor
        textfieldFont_Size.borderStyle = UITextBorderStyle.None
        textfieldFont_Size.addTarget(self, action: #selector(ImageWishViewController.textFontDidChange(_:)), forControlEvents: UIControlEvents.EditingDidBegin)
        
        view.addSubview(textfieldFont_Size)
        
        //Choose font_size of text here
        textfieldIcon.text = "animal"
        textfieldIcon.textColor = UIColor.whiteColor()
        textfieldIcon.frame = CGRectMake(sizeScreen.width*0.65, sizeScreen.height*0.81 , sizeScreen.width*0.4, sizeScreen.width*0.07)
        textfieldIcon.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        self.textfieldIcon.delegate = self
        let dummyView1:UIView = UIView.init(frame: CGRect(x: 0, y: textfieldFont_Size.frame.size.height - width, width:  textfieldFont_Size.frame.size.width, height: textfieldFont_Size.frame.size.height))
        textfieldIcon.inputView = dummyView1 // Hide keyboard, but show blinking cursor
        textfieldIcon.borderStyle = UITextBorderStyle.None
        textfieldIcon.addTarget(self, action: #selector(ImageWishViewController.textIconDidChange(_:)), forControlEvents: UIControlEvents.EditingDidBegin)
        textfieldIcon.hidden = true
        view.addSubview(textfieldIcon)
        
        
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Light)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        
        alertViewText = AlertView(frame: CGRect(x: 20, y: 25, width: self.view.frame.width - 40, height: self.view.frame.height/7 * 4), alertText: "Add your wish here", buttons_count: BUTTONS_COUNT.TWO, buttons_text: ["Ok","Cancel"], actions_name: ["onButtonClick:","onButtonClick:"], target: self)
        
        colorPicker = AlertView(frame: CGRect(x: 20, y: 25, width: self.view.frame.width - 40, height: self.view.frame.height/7 * 4),  buttons_count: BUTTONS_COUNT.TWO, buttons_text: ["Ok","Cancel"], actions_name: ["onButtonClick:","onButtonClick:"], target: self)
        
        imageBackground = AlertView(frame: CGRect(x: 20, y: 25, width: self.view.frame.width - 40, height: self.view.frame.height-100),  buttons_count: BUTTONS_COUNT.TWO, buttons_text: ["Ok","Cancel"], actions_name: ["onButtonClick:","onButtonClick:"], target: self,idAleart : 1)
        pickerFontView = AlertView(frame: CGRect(x: 20, y: 25, width: self.view.frame.width - 40, height: self.view.frame.height/7 * 4),  buttons_count: BUTTONS_COUNT.TWO, buttons_text: ["Ok","Cancel"], actions_name: ["onButtonClick:","onButtonClick:"], target: self,idAleart : 2)
        
        pickerIconType = AlertView(frame: CGRect(x: 20, y: 25, width: self.view.frame.width - 40, height: self.view.frame.height/7 * 4),  buttons_count: BUTTONS_COUNT.TWO, buttons_text: ["Ok","Cancel"], actions_name: ["onButtonClick:","onButtonClick:"], target: self,idAleart : 3)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ImageWishViewController.onViewDidTouch(_:)), name: "ViewDidTouch", object: nil)
        
        // let s:String = self.fileInDoccumentDirectory("/ImageWish/Collection/pic.png")
        // self.loadImageFromPath(s)
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    @objc func onViewDidTouch(notification:NSNotification)
    {
        let color:UIColor =  colorPicker.colorpicker.getColor()
        
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidChange(textField: UITextField) {
        
        
        self.alertViewText.alpha = 1 //you must use self... if you wont it will give you an error
        self.blurEffectView.alpha = 1
        aleartID = 1
        self.view.addSubview(blurEffectView)
        self.view.addSubview(alertViewText)
        
        
        
        
    }
    func textFontDidChange(textField: UITextField) {
        
        self.pickerFontView.alpha = 1 //you must use self... if you wont it will give you an error
        self.blurEffectView.alpha = 1
        aleartID = 4
        self.view.addSubview(blurEffectView)
        self.view.addSubview(pickerFontView)
    }
    func textIconDidChange(textField: UITextField) {
        
        self.pickerIconType.alpha = 1 //you must use self... if you wont it will give you an error
        self.blurEffectView.alpha = 1
        aleartID = 5
        self.view.addSubview(blurEffectView)
        self.view.addSubview(pickerIconType)
    }
    
    func chooseModeButtonPressed()
    {
        if(ImageWishViewController.mode == 1)
        {
            ImageWishViewController.mode = 2
            btnChooseMode.setImage(UIImage(named: "iconmode"), forState: .Normal)
            btnEraser.setImage(UIImage(named: "eraser_disable"), forState: .Normal)
            btnEraser.hidden = false
            textfieldIcon.hidden = false
            textfieldFont_Size.hidden = true
            textfieldContent.hidden = true
            btnPickColor.hidden = true
            iconView.hidden = false
            
        }
        else if ImageWishViewController.mode == 2 || ImageWishViewController.mode == 3
        {
            ImageWishViewController.mode = 1
            btnChooseMode.setImage(UIImage(named: "textmode"), forState: .Normal)
            btnEraser.hidden = true
            textfieldIcon.hidden = true
            textfieldFont_Size.hidden = false
            textfieldContent.hidden = false
            btnPickColor.hidden = false
            iconView.hidden = true
            
        }
        
    }
    func eraseButtonPressed()
    {
        if (ImageWishViewController.mode == 2)
        {
            ImageWishViewController.pos = CGPoint(x: -1, y: -1)
            ImageWishViewController.mode = 3
            btnEraser.setImage(UIImage(named: "eraser_enable"), forState: .Normal)
            viewToDraw.drawRect(CGRectMake(0, 0, 10, 10))
        }
        else if (ImageWishViewController.mode == 3)
        {
            ImageWishViewController.mode = 2
            btnEraser.setImage(UIImage(named: "eraser_disable"), forState: .Normal)
        }
    }
    
    func chooseImageButtonPressed()
    {
        ImageWishViewController.isChangeBackground = true
        self.imageBackground.alpha = 1 //you must use self... if you wont it will give you an error
        self.blurEffectView.alpha = 1
        aleartID = 3
        self.view.addSubview(blurEffectView)
        self.view.addSubview(imageBackground)
        
    }
    func getDoccumentURL()->NSURL
    {
        let doccumentURL:NSURL = NSFileManager.defaultManager().URLsForDirectory(NSSearchPathDirectory.DocumentDirectory, inDomains: .UserDomainMask)[0] as NSURL
        return doccumentURL
        
    }
    func fileInDoccumentDirectory(filename:String)->String
    {
        let fileURL = getDoccumentURL().URLByAppendingPathComponent(filename)
        return fileURL.path!
        
    }
    func loadImageFromPath(path:String)->UIImage
    {
        let image = UIImage(contentsOfFile: path)
        
        return image!
    }
    
    func thumbsUpButtonPressed() {
        aleartID = 2
        self.colorPicker.alpha = 1 //you must use self... if you wont it will give you an error
        self.blurEffectView.alpha = 1
        self.view.addSubview(blurEffectView)
        self.view.addSubview(colorPicker)
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func handleTap(recognizer:UITapGestureRecognizer) {
        ImageWishViewController.pos = recognizer.locationInView(recognizer.view)
        viewToDraw.drawRect(CGRectMake(0, 0, 10, 10))
        
        
    }
    func onButtonClick(button:UIButton){
        
        if(button.titleLabel?.text == "Ok"){
            //here you will call function when the user pressing Ok
            //here for example i will change thye background colour
            button.alpha = 0.5
            
            if aleartID == 1
            {
                self.view.endEditing(true)
                ImageWishViewController.contentforText = alertViewText.alertTextView.text
                textfieldContent.text = ImageWishViewController.contentforText
                viewToDraw.drawRect(CGRectMake(0, 0, 10, 10))
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    self.alertViewText.alpha = 0 //you must use self... if you wont it will give you an error
                    self.blurEffectView.alpha = 0
                    }, completion: { (Bool) -> Void in
                        self.view.endEditing(true)
                        self.alertViewText.removeFromSuperview()
                        self.blurEffectView.removeFromSuperview()
                        button.alpha = 1
                })
            }
                
            else if aleartID == 2
            {
                ImageWishViewController.colorforText = colorPicker.colorpicker.getColor()
                btnPickColor.backgroundColor = ImageWishViewController.colorforText
                viewToDraw.drawRect(CGRectMake(0, 0, 10, 10))
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    self.colorPicker.alpha = 0 //you must use self... if you wont it will give you an error
                    self.blurEffectView.alpha = 0
                    }, completion: { (Bool) -> Void in
                        self.view.endEditing(true)
                        self.colorPicker.removeFromSuperview()
                        self.blurEffectView.removeFromSuperview()
                        button.alpha = 1
                })
                
            }
            else if aleartID == 3
            {
                //colorforText = colorPicker.colorpicker.getColor()
                viewToDraw.drawRect(CGRectMake(0, 0, 10, 10))
                ImageWishViewController.isChangeBackground = false
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    self.imageBackground.alpha = 0 //you must use self... if you wont it will give you an error
                    self.blurEffectView.alpha = 0
                    }, completion: { (Bool) -> Void in
                        self.view.endEditing(true)
                        self.imageBackground.removeFromSuperview()
                        self.blurEffectView.removeFromSuperview()
                        button.alpha = 1
                })
                
            }
            else if aleartID == 4
            {
                self.textfieldFont_Size.text = "\(ImageWishViewController.fontName)   \(ImageWishViewController.fontSize)"
                viewToDraw.drawRect(CGRectMake(0, 0, 10, 10))
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    self.pickerFontView.alpha = 0 //you must use self... if you wont it will give you an error
                    self.blurEffectView.alpha = 0
                    }, completion: { (Bool) -> Void in
                        self.view.endEditing(true)
                        self.pickerFontView.removeFromSuperview()
                        self.blurEffectView.removeFromSuperview()
                        button.alpha = 1
                })
                
            }
            else if aleartID == 5
            {
                // self.textfieldFont_Size.text = "\(fontName)   \(fontSize)"
                //viewToDraw.drawRect(CGRectMake(0, 0, 10, 10))
                self.textfieldIcon.text = ImageWishViewController.iconType
                self.iconView.ReloadIconView()
                // update data for
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    self.pickerIconType.alpha = 0 //you must use self... if you wont it will give you an error
                    self.blurEffectView.alpha = 0
                    }, completion: { (Bool) -> Void in
                        self.view.endEditing(true)
                        self.pickerIconType.removeFromSuperview()
                        self.blurEffectView.removeFromSuperview()
                        button.alpha = 1
                })
                
            }
            
            
        }else if(button.titleLabel?.text == "Cancel"){
            button.alpha = 0.5
            
            if aleartID == 1
            {
                self.view.endEditing(true)
                UIView.animateWithDuration(0.03, animations: { () -> Void in
                    self.alertViewText.alpha = 0 //you must use self... if you wont it will give you an error
                    self.blurEffectView.alpha = 0
                    }, completion: { (Bool) -> Void in
                        self.alertViewText.removeFromSuperview()
                        self.blurEffectView.removeFromSuperview()
                        button.alpha = 1 //peace :)
                })
            }
            else if aleartID == 2
            {
                self.view.endEditing(true)
                UIView.animateWithDuration(0.03, animations: { () -> Void in
                    self.colorPicker.alpha = 0 //you must use self... if you wont it will give you an error
                    self.blurEffectView.alpha = 0
                    }, completion: { (Bool) -> Void in
                        self.colorPicker.removeFromSuperview()
                        self.blurEffectView.removeFromSuperview()
                        button.alpha = 1 //peace :)
                })
                
            }
            else if aleartID == 3
            {
                self.view.endEditing(true)
                UIView.animateWithDuration(0.03, animations: { () -> Void in
                    self.imageBackground.alpha = 0 //you must use self... if you wont it will give you an error
                    self.blurEffectView.alpha = 0
                    }, completion: { (Bool) -> Void in
                        self.imageBackground.removeFromSuperview()
                        self.blurEffectView.removeFromSuperview()
                        button.alpha = 1 //peace :)
                })
                
            }
            else if aleartID == 4
            {
                self.view.endEditing(true)
                
                UIView.animateWithDuration(0.03, animations: { () -> Void in
                    self.pickerFontView.alpha = 0 //you must use self... if you wont it will give you an error
                    self.blurEffectView.alpha = 0
                    
                    }, completion: { (Bool) -> Void in
                        self.pickerFontView.removeFromSuperview()
                        self.blurEffectView.removeFromSuperview()
                        button.alpha = 1
                        
                        //peace :)
                })
                
            }
            else if aleartID == 5
            {
                self.view.endEditing(true)
                
                UIView.animateWithDuration(0.03, animations: { () -> Void in
                    self.pickerIconType.alpha = 0 //you must use self... if you wont it will give you an error
                    self.blurEffectView.alpha = 0
                    
                    }, completion: { (Bool) -> Void in
                        self.pickerIconType.removeFromSuperview()
                        self.blurEffectView.removeFromSuperview()
                        button.alpha = 1
                        
                        //peace :)
                })
                
            }
            
            
            
        }else{
            NSLog("NO FUNCTION FOR THE BUTTON NAMED \(button.titleLabel?.text)") //I use the text of the label as an id / name for the button
        }
    }
    override func viewWillAppear(animated: Bool) {
        
        iconView.isAtGallery = false
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
