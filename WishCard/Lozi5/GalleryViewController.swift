//
//  GalleryViewController.swift
//  Lozi5
//
//  Created by AnhLtv on 5/8/16.
//  Copyright © 2016 SummerLab. All rights reserved.
//

import UIKit
import CoreData

class GalleryViewController: UIViewController {
    
    var galleryView:CollectionImageView!
    var sizeScreen:CGSize!
    var deatailView:AlertView!
    var blurEffectView:UIVisualEffectView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let value = UIInterfaceOrientation.Portrait.rawValue
        // UIDevice.currentDevice().setValue(value, forKey: "portrait")
        sizeScreen = UIScreen.mainScreen().bounds.size
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Light)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        galleryView = CollectionImageView(frame: CGRectMake(3, 17, sizeScreen.width-6, sizeScreen.height))
        self.view.backgroundColor = UIColor(red: 26.0/255.0, green: 132.0/255.0, blue: 70.0/255.0, alpha:1.0)
        
        view.addSubview(galleryView)
        
        let frame:CGRect = CGRectMake(8,sizeScreen.height * 0.14,sizeScreen.width-16,sizeScreen.height * 0.72)
        deatailView = AlertView(frame: frame,  buttons_count: BUTTONS_COUNT.TWO, buttons_text: ["Share","Delete"], actions_name: ["onButtonClick:","onButtonClick:"], target: self,idAleart : 4)
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(GalleryViewController.onViewDidSelectimageToShare(_:)), name: "ViewDidSelectImageWishViewController.imageToShare", object: nil)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
        self.galleryView.ReloadCollectionView()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func onViewDidSelectimageToShare(notification:NSNotification)
    {
        
        deatailView.reloadData()
        self.deatailView.alpha = 1 //you must use self... if you wont it will give you an error
        self.blurEffectView.alpha = 1
        self.view.addSubview(blurEffectView)
        self.view.addSubview(deatailView)
        
    }
    
    func onButtonClick(button:UIButton){
        
        if(button.titleLabel?.text == "Share"){
            //here you will call function when the user pressing Ok
            //here for example i will change thye background colour
            button.alpha = 0.5
            
            let img = UIImage(contentsOfFile: imageGallery)
            let vc = UIActivityViewController(activityItems: [img!], applicationActivities: nil)
            
            UIView.animateWithDuration(0.1, animations: { () -> Void in
                self.deatailView.alpha = 0 //you must use self... if you wont it will give you an error
                self.blurEffectView.alpha = 0
                }, completion: { (Bool) -> Void in
                    self.view.endEditing(true)
                    self.deatailView.removeFromSuperview()
                    self.blurEffectView.removeFromSuperview()
                    button.alpha = 1
                    self.presentViewController(vc, animated: true, completion: nil);
            })
            
            
            
        }
        else if button.titleLabel?.text == "Delete"
        {
            
            //Delete at core data
            let separators = NSCharacterSet(charactersInString: "Documents/")
            let nametoRemove:[String]  = imageGallery.componentsSeparatedByCharactersInSet(separators)
            DeleteImage(nametoRemove[nametoRemove.count-1])
            self.galleryView.ReloadCollectionView()
            
            do {
                try   NSFileManager.defaultManager().removeItemAtPath(imageGallery)
                
            } catch {
                
            }
            
            
            //  fileManager.removeItemAtPath(filePath, error: error)
            UIView.animateWithDuration(0.1, animations: { () -> Void in
                self.deatailView.alpha = 0 //you must use self... if you wont it will give you an error
                self.blurEffectView.alpha = 0
                }, completion: { (Bool) -> Void in
                    self.view.endEditing(true)
                    self.deatailView.removeFromSuperview()
                    self.blurEffectView.removeFromSuperview()
                    button.alpha = 1
                    //self.presentViewController(vc, animated: true, completion: nil);
            })
        }
    }
    func DeleteImage(nameOfImage:String)
    {
        let request = NSFetchRequest(entityName: "ImageLink")
        request.returnsObjectsAsFaults = false
        
        do {
            
            let appDel:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let context:NSManagedObjectContext = appDel.managedObjectContext
            
            let results = try context.executeFetchRequest(request)
            if results.count > 0
            {
                
                for result in results
                {
                    
                    
                    if let content = result.valueForKey("imagelink")
                    {
                        if content as! String == nameOfImage
                        {
                            context.deleteObject(result as! NSManagedObject)
                        }
                    }
                    
                    
                }
                do {
                    try context.save()
                } catch {
                    print("Dim background error")
                }
                
            }
            
        } catch {
            print("Dim background error")
        }
        
    }
    
    
}
