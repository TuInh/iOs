//
//  CustomDraw.swift
//  Lozi5
//
//  Created by AnhLtv on 4/17/16.
//  Copyright © 2016 SummerLab. All rights reserved.
//

import UIKit
import CoreData
class CustomDraw: UIView {
    var sizeScreen = CGRect()
    var realwidth:CGFloat = 0
    var txtlabel:UILabel = UILabel()
    var imgView:UIImageView = UIImageView()
    var imagewishController:ImageWishViewController = ImageWishViewController()
    var idx = 4
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        realwidth = self.frame.width
        sizeScreen = UIScreen.mainScreen().bounds
        self.backgroundColor = UIColor.clearColor()
        initView()
    }
    func initView()
    {
        txtlabel = UILabel(frame: CGRectMake(0,0,sizeScreen.width-16,sizeScreen.height * 0.6 ))
        
        
        ImageWishViewController.pos = CGPoint(x: 0, y: -0)
        // txtlabel = UILabel(frame: CGRectMake(50,50,200,210))
        txtlabel.text = "Add your wish here"
        txtlabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
        txtlabel.numberOfLines = 10
        txtlabel.tag = 3
        txtlabel.textColor = UIColor.blackColor()
        txtlabel.sizeToFit()
        txtlabel.textAlignment = NSTextAlignment.Center
        
        let frameLbl:CGRect = txtlabel.frame
        let pointCenter:CGPoint = CGPointMake(CGRectGetMidX(frameLbl), CGRectGetMinY(frameLbl))
        txtlabel.layer.anchorPoint = CGPointMake(0.5, 0)
        txtlabel.layer.position = pointCenter
        txtlabel.center = pointCenter
        txtlabel.transform = CGAffineTransformMakeTranslation(0.5, 0)
        if ImageWishViewController.fontSize == nil {
            ImageWishViewController.fontSize = 10
        }
        if ImageWishViewController.fontName == nil {
            ImageWishViewController.fontName = "Copperplate"
        }
        txtlabel.font = UIFont(name: ImageWishViewController.fontName, size: CGFloat(ImageWishViewController.fontSize));
        imagePathBackground = NSBundle.mainBundle().resourcePath! + "/ImageWish/Collection/il_1.png"
        let img = UIImage(contentsOfFile: imagePathBackground)
        imgView = UIImageView(image: img)
        imgView.tag = 2
        imgView.contentMode = UIViewContentMode.ScaleAspectFit
        imgView.frame = CGRectMake(0, 0,sizeScreen.width-16,sizeScreen.height * 0.6 )
        self.insertSubview(imgView, atIndex: 0)
        
        self.addSubview(txtlabel)
        
        
    }
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    func getDoccumentURL()->NSURL
    {
        let doccumentURL:NSURL = NSFileManager.defaultManager().URLsForDirectory(NSSearchPathDirectory.DocumentDirectory, inDomains: NSSearchPathDomainMask.UserDomainMask)[0] as NSURL
        return doccumentURL
    }
    func fileInDocumentDirectory(fileName:String)->String
    {
        let fileURL = getDoccumentURL().URLByAppendingPathComponent(fileName)
        return fileURL.path!
    }
    func saveImage(image:UIImage,path:String)->Bool
    {
        let pngImageData = UIImagePNGRepresentation(image)
        let result = pngImageData?.writeToFile(path, atomically: true)
        return result!
    }
    func loadImageFromPath(path:String)->UIImage?
    {
        let image = UIImage(contentsOfFile: path)
        if image == nil
        {
            
            
        }
        
        return image
    }
    
    override func drawRect(rect: CGRect) {
        // Drawing code
        if ImageWishViewController.mode == 1
        {
            for subview in self.subviews
            {
                if subview.tag == 2
                {
                    subview.removeFromSuperview()
                    let img:UIImage!
                    if(imagePathBackground == nil)
                    {
                        
                        imagePathBackground = NSBundle.mainBundle().resourcePath! + "/ImageWish/Collection/il_1.png"
                        img = UIImage(contentsOfFile: imagePathBackground)
                    }
                    else
                    {
                        
                        img = UIImage(contentsOfFile: imagePathBackground)
                        
                    }
                    let imgView = UIImageView(image: img)
                    imgView.tag = 2
                    imgView.contentMode = UIViewContentMode.ScaleAspectFit
                    imgView.frame = CGRectMake(0, 0,sizeScreen.width-16,sizeScreen.height * 0.6 )
                    self.insertSubview(imgView, atIndex: 0)
                    
                    
                }
                if subview.tag == 3 && ImageWishViewController.isChangeBackground == false
                {
                    subview.removeFromSuperview()
                    txtlabel = UILabel(frame: CGRectMake(ImageWishViewController.pos.x,ImageWishViewController.pos.y,sizeScreen.width - 16,sizeScreen.height))
                    txtlabel.text = ImageWishViewController.contentforText
                    txtlabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
                    txtlabel.numberOfLines = 10
                    txtlabel.tag = 3
                    txtlabel.font = UIFont(name: ImageWishViewController.fontName, size: CGFloat(ImageWishViewController.fontSize))
                    txtlabel.textColor = ImageWishViewController.colorforText
                    txtlabel.sizeToFit()
                    txtlabel.textAlignment = NSTextAlignment.Center
                    self.addSubview(txtlabel)
                    
                }
            }
        }
        else if(ImageWishViewController.mode == 2)
        {
            if ImageWishViewController.isChangeBackground == true
            {
                for subview in self.subviews
                {
                    if subview.tag == 2
                    {
                        subview.removeFromSuperview()
                        let img:UIImage!
                        if(imagePathBackground == nil)
                        {
                            
                            imagePathBackground = NSBundle.mainBundle().resourcePath! + "/ImageWish/Collection/il_1.png"
                            img = UIImage(contentsOfFile: imagePathBackground)
                            
                        }
                        else
                        {
                            
                            img = UIImage(contentsOfFile: imagePathBackground)
                            
                        }
                        let imgView = UIImageView(image: img)
                        imgView.tag = 2
                        imgView.contentMode = UIViewContentMode.ScaleAspectFit
                        imgView.frame = CGRectMake(0, 0,sizeScreen.width-16,sizeScreen.height * 0.6 )
                        self.insertSubview(imgView, atIndex: 0)
                        
                        
                    }
                }
            }
            else
            {
                if imagePathIcon != nil
                {
                    imgView = UIImageView(image: UIImage(contentsOfFile: imagePathIcon))
                    imgView.contentMode = UIViewContentMode.ScaleAspectFit
                    imgView.frame = CGRectMake(ImageWishViewController.pos.x,ImageWishViewController.pos.y, 50, 50)
                    imgView.tag = idx
                    idx += 1
                    self.addSubview(imgView)
                }
            }
            
            
            
        }
        else if ImageWishViewController.mode == 3
        {
            for subview in self.subviews
            {
                if subview.tag == 2
                {
                    subview.removeFromSuperview()
                    let img:UIImage!
                    if(imagePathBackground == nil)
                    {
                        
                        imagePathBackground = NSBundle.mainBundle().resourcePath! + "/ImageWish/Collection/il_1.png"
                        img = UIImage(contentsOfFile: imagePathBackground)
                        
                    }
                    else
                    {
                        img = UIImage(contentsOfFile: imagePathBackground)
                        
                    }
                    let imgView = UIImageView(image: img)
                    imgView.tag = 2
                    imgView.contentMode = UIViewContentMode.ScaleAspectFit
                    imgView.frame = CGRectMake(0, 0,sizeScreen.width-16,sizeScreen.height * 0.6 )
                    self.insertSubview(imgView, atIndex: 0)
                    
                }
                    
                else if(subview.tag >= 4 )
                {
                    if CGRectContainsPoint(subview.frame, ImageWishViewController.pos) == true
                    {
                        subview.removeFromSuperview()
                    }
                }
            }
        }
        else if ImageWishViewController.mode == 4
        {
            UIGraphicsBeginImageContextWithOptions(bounds.size, false, 1)
            self.drawViewHierarchyInRect(self.bounds, afterScreenUpdates: true)
            ImageWishViewController.imageToShare = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            
            
            
        }
        else if ImageWishViewController.mode == 6
        {
            UIGraphicsBeginImageContextWithOptions(bounds.size, false, 1)
            self.drawViewHierarchyInRect(self.bounds, afterScreenUpdates: true)
            ImageWishViewController.imageToShare = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            let currentDate = NSDate()
            let calendar = NSCalendar.currentCalendar()
            let dateComponents = calendar.components([NSCalendarUnit.Day, NSCalendarUnit.Month, NSCalendarUnit.Year, NSCalendarUnit.WeekOfYear, NSCalendarUnit.Hour, NSCalendarUnit.Minute, NSCalendarUnit.Second, NSCalendarUnit.Nanosecond], fromDate: currentDate)
            let nameImageToSave:String = "IMG\(dateComponents.day)_\(dateComponents.month)_\(dateComponents.year)_\(dateComponents.hour)_\(dateComponents.minute)_\(dateComponents.second)_\(dateComponents.nanosecond)"
            var nametoSave:String!
            nametoSave = fileInDocumentDirectory(nameImageToSave)
            
            let issaveOk = saveImage(ImageWishViewController.imageToShare, path: nametoSave)
            
            let appDel:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let context:NSManagedObjectContext = appDel.managedObjectContext
            //NSString *newID = [[NSUUID UUID] UUIDString];
            let newID:String = NSUUID().UUIDString
            let newLink = NSEntityDescription.insertNewObjectForEntityForName("ImageLink", inManagedObjectContext: context) as NSManagedObject
            newLink.setValue(newID, forKey: "imageid")
            newLink.setValue(nameImageToSave, forKey: "imagelink")
            
            do {
                try context.save()
            } catch {
                print("Dim background error")
            }
            
            
            
        }
            
        else if ImageWishViewController.mode == 5
        {
            for subview in subviews
            {
                
                subview.removeFromSuperview()
                
            }
            initView()
        }
        
    }
    
    
}
