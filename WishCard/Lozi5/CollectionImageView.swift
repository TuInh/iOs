//
//  CollectionImageView.swift
//  Lozi5
//
//  Created by AnhLtv on 4/24/16.
//  Copyright © 2016 SummerLab. All rights reserved.
//

import UIKit
import CoreData
import Foundation
var imagePathBackground:String!
var imagePathIcon:String!
var imageGallery:String!

class CollectionImageView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    var collectionView : UICollectionView?
    var imageFileNameArray : NSArray?
    var isAtGallery = false
    let barSize : CGFloat = 44.0
    let kCellReuse : String = "PackCell"
    let kCellheaderReuse : String = "PackHeader"
    var selectedIndex = -1
    var resourcePath:String!
    var isIcon:Bool!
    var lstGallery:NSMutableArray!
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        isAtGallery = true
        
        self.backgroundColor = UIColor.clearColor()
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let widthEach = (frame.width - 20)/2
        layout.sectionInset = UIEdgeInsets(top: 20, left: 5, bottom: 10, right: 5)
        layout.itemSize = CGSize(width: widthEach, height: widthEach/3.4*4)
        isIcon = false
        
        self.collectionView = UICollectionView(frame: CGRectMake(0, 0, frame.width, frame.height), collectionViewLayout: layout)
        self.collectionView!.dataSource = self
        self.collectionView!.delegate = self
        self.collectionView!.registerClass(MyCollectionViewCell.self, forCellWithReuseIdentifier: "MyCollectionViewCell")
        self.collectionView!.backgroundColor = UIColor.clearColor()
        
        
        
        // Get Data
        let request = NSFetchRequest(entityName: "ImageLink")
        request.returnsObjectsAsFaults = false
        lstGallery = NSMutableArray()
        lstGallery.removeAllObjects()
        do {
            
            let appDel:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let context:NSManagedObjectContext = appDel.managedObjectContext
            let results = try context.executeFetchRequest(request)
            
            
            
            if results.count > 0
            {
                
                for result in results
                {
                    // context.deleteObject(result as! NSManagedObject)
                    
                    if let content = result.valueForKey("imagelink")
                    {
                        
                        lstGallery.addObject(content)
                    }
                    
                    
                }
                
                
            }
            
        } catch {
            print("Dim background error")
        }
        
        
        self.addSubview(self.collectionView!)
    }
    init(frame: CGRect, folderName : String) {
        super.init(frame: frame)
        isAtGallery = false
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let widthEach = (frame.width - 60)/2
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 10, right: 20)
        layout.itemSize = CGSize(width: widthEach, height: widthEach/3*4)
        isIcon = false
        if folderName.containsString("Collection") == false
        {
            isIcon = true
            layout.scrollDirection = UICollectionViewScrollDirection.Horizontal
            let widthEach = frame.height - 5
            layout.sectionInset = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
            layout.itemSize = CGSize(width: widthEach, height: widthEach)
            
        }
        
        // Get project root path
        resourcePath = NSBundle.mainBundle().resourcePath!;
        
        // Get "/ImageWish/Collection" folder path
        resourcePath =  resourcePath + "/ImageWish/" + folderName;
        
        do
        {
            //This function return an array of file name in "/ImageWish/Collection" folder
            self.imageFileNameArray = try NSFileManager.defaultManager().contentsOfDirectoryAtPath(resourcePath);
            
        }
        catch
        {
            self.imageFileNameArray = nil;
        }
        //
        //layout.minimumLineSpacing = CGFloat.max
        
        
        self.collectionView = UICollectionView(frame: CGRectMake(0, 0, frame.width, frame.height), collectionViewLayout: layout)
        self.collectionView!.dataSource = self
        self.collectionView!.delegate = self
        self.collectionView!.registerClass(MyCollectionViewCell.self, forCellWithReuseIdentifier: "MyCollectionViewCell")
        self.collectionView!.backgroundColor = UIColor.whiteColor()
        
        //Quen mat dong nay nen khong show dc collection nhe
        self.addSubview(self.collectionView!)
        
    }
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int
    {
        return 1
        
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        if(isAtGallery == false)
        {
            if (self.imageFileNameArray != nil)
            {
                
                return self.imageFileNameArray!.count;
            }
            else
            {
                return 0
                
            }
            
        }
        else
        {
            return lstGallery.count
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        
        let cell:MyCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("MyCollectionViewCell", forIndexPath: indexPath) as! MyCollectionViewCell
        
        
        var imagePath:String!
        let image:UIImage!
        if isAtGallery == false
        {
            imagePath = resourcePath + "/" + (self.imageFileNameArray![indexPath.row] as! String)
            image = UIImage(contentsOfFile: imagePath);
        }
        else
        {
            imagePath = lstGallery.objectAtIndex(indexPath.row) as! String
            imagePath = fileInDocumentDirectory(imagePath)
            image = UIImage(contentsOfFile: imagePath);
            
            
        }
        
        cell.img.image = image;
        cell.img.frame = CGRectMake(0, 0, cell.frame.width, cell.frame.height)
        
        
        
        
        if selectedIndex == indexPath.row
        {
            cell.layer.borderWidth = 5.0
            cell.layer.borderColor = UIColor.greenColor().CGColor
            
        }
        else
        {
            cell.layer.borderWidth = 0.0
        }
        return cell
        
    }
    func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool
    {
        return true
    }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
    {
        
        
        let cellCount = collectionView.visibleCells().count;
        for var i in 0...(cellCount-1)
        {
            let cell = collectionView.visibleCells()[i]
            cell.layer.borderWidth = 0.0
            cell.setNeedsDisplay()
        }
        
        selectedIndex = indexPath.row
        
        let cell = collectionView.cellForItemAtIndexPath(indexPath)
        
        if isAtGallery == false
        {
            
            if isIcon == true
            {
                imagePathIcon = resourcePath + "/" + (self.imageFileNameArray![indexPath.row
                    ] as! String)
                drawRect(CGRectMake(0, 0, 10, 10))
                
            }
            else
            {
                imagePathBackground = resourcePath + "/" + (self.imageFileNameArray![indexPath.row
                    ] as! String)
                
            }
            
        }
        else
        {
            imageGallery = lstGallery.objectAtIndex(indexPath.row) as! String
            imageGallery = fileInDocumentDirectory(imageGallery)
            NSNotificationCenter.defaultCenter().postNotificationName("ViewDidSelectImageWishViewController.imageToShare", object: self)
            
            
            
        }
        
        cell?.layer.borderColor = UIColor.greenColor().CGColor
        cell?.layer.borderWidth = 5.0
        cell?.setNeedsDisplay()
        
    }
    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath)
    {
        
        
        selectedIndex = -1
        
        let cell = collectionView.cellForItemAtIndexPath(indexPath)
        cell?.layer.borderWidth = 0.0
        cell?.setNeedsDisplay()
        
    }
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
    
    
    
    
    func ReloadIconView()
    {
        // Get project root path
        selectedIndex = -1
        resourcePath = NSBundle.mainBundle().resourcePath!;
        
        // Get "/ImageWish/Collection" folder path
        resourcePath =  resourcePath + "/ImageWish/Sticker/" + ImageWishViewController.iconType;
        
        do
        {
            //This function return an array of file name in "/ImageWish/Collection" folder
            self.imageFileNameArray = try NSFileManager.defaultManager().contentsOfDirectoryAtPath(resourcePath);
            
        }
        catch
        {
            self.imageFileNameArray = nil;
        }
        
        
        self.collectionView?.reloadData()
    }
    func ReloadCollectionView(){
        // Get Data
        let request = NSFetchRequest(entityName: "ImageLink")
        request.returnsObjectsAsFaults = false
        lstGallery = NSMutableArray()
        lstGallery.removeAllObjects()
        do {
            
            let appDel:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let context:NSManagedObjectContext = appDel.managedObjectContext
            let results = try context.executeFetchRequest(request)
            
            
            
            if results.count > 0
            {
                
                for result in results
                {
                    // context.deleteObject(result as! NSManagedObject)
                    
                    if let content = result.valueForKey("imagelink")
                    {
                        
                        lstGallery.addObject(content)
                    }
                    
                    
                }
                
            }
            
        } catch {
            print("Dim background error")
        }
        
        self.collectionView?.reloadData();
    }
    
}
