//
//  TextViewController.swift
//  Lozi5
//
//  Created by AnhLtv on 4/10/16.
//  Copyright © 2016 SummerLab. All rights reserved.
//

import UIKit
import CoreData
var lstBirth:NSMutableArray = NSMutableArray()
class TextWish
{
    var avatarImg:UIImage
    var textwish:String
    var nextbtn:UIImage
    
    init(avar:UIImage,textWish:String,nextbtn:UIImage)
    {
        self.avatarImg = avar
        self.nextbtn = nextbtn
        self.textwish = textWish
    }
}
class TextViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet var wishTabbarItem: UITabBarItem!
    @IBOutlet var tableView: UITableView!
    var heightCell:CGFloat = 0
    var wishes = [TextWish]()
    var readxml:ReadXml? = nil
    var titleLst:[String]!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLst = ["Birthday","Valentine","Symphanthy","New Year","Thank You"]
        //Read xml and save to core data
        let appDel:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context:NSManagedObjectContext = appDel.managedObjectContext
        
        var isNeedLoadXML = true;
        let request = NSFetchRequest(entityName: "TextWish")
        request.returnsObjectsAsFaults = false
        do {
            let results = try context.executeFetchRequest(request)
            
            if results.count > 0
            {
                isNeedLoadXML = false;
            }
        }
        catch {
            print("Dim background error")
        }
        
        if(isNeedLoadXML)
        {
            self.readxml = ReadXml(fileName: "Birthday", consumer: self);
            self.readxml!.beginParsing()
        }
        else
        {
            loadCoreData()
            loadWishes()
        }
        
        
        // self.navigationController?.navigationBarHidden = true
        self.view.backgroundColor = UIColor(red: 26.0/255.0, green: 132.0/255.0, blue: 70.0/255.0, alpha:1.0)
        heightCell = CGFloat(self.view.frame.height - 75 )/5
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        tableView.backgroundColor = UIColor(red: 26.0/255.0, green: 132.0/255.0, blue: 70.0/255.0, alpha:1.0)
        self.navigationItem.hidesBackButton = false
        // Do any additional setup after loading the view.
        
    }
   
    // function for fix screen portrait
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.Portrait
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        dispatch_async(dispatch_get_main_queue(), {  if segue.identifier == "ShowTextDetailSegue" {
            if let destination = segue.destinationViewController as? TextDetailViewController {
                if let blogIndex = self.tableView.indexPathForSelectedRow?.row {
                    destination.index = blogIndex
                    destination.txtTitle.text = self.titleLst[Int (blogIndex)]
                }
            }
            }})
        
        
        
        
    }
    
    
    func loadXMLCompleted()
    {
        SaveCoreData(readxml!.myList)
        loadCoreData()
        loadWishes()
    }
    
    func loadWishes()
    {
        let avar1 = UIImage(named: "birth")
        let next = UIImage(named: "next")
        let avar2 = UIImage(named: "love")
        let avar3 = UIImage(named: "symphanthy")
        let avar4 = UIImage(named: "snow")
        let avar5 = UIImage(named: "thankyou")
        
        let textwish1 = TextWish(avar: avar1!, textWish: "Birthday", nextbtn: next!)
        let textwish2 = TextWish(avar: avar2!, textWish: "Valentine", nextbtn: next!)
        let textwish3 = TextWish(avar: avar3!, textWish: "Symphanthy", nextbtn: next!)
        let textwish4 = TextWish(avar: avar4!, textWish: "New Year", nextbtn: next!)
        let textwish5 = TextWish(avar: avar5!, textWish: "Thank You", nextbtn: next!)
        
        wishes += [textwish1,textwish2,textwish3,textwish4,textwish5]
        
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return heightCell
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return wishes.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        
        let cellIdentifier = "TextTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! TextTableViewCell
        let wish = wishes[indexPath.row]
        
        cell.contentView.backgroundColor = UIColor(red: 26.0/255.0, green: 132.0/255.0, blue: 70.0/255.0, alpha:1.0)
        
        cell.avarImg.image = wish.avatarImg
        
        
        
        cell.avarText.text = wish.textwish
        cell.btnNext.image = wish.nextbtn
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func SaveCoreData(list:NSMutableArray)
    {
        
        let appDel:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context:NSManagedObjectContext = appDel.managedObjectContext
        
        var idex = 0
        for str in list{
            
            let newWish = NSEntityDescription.insertNewObjectForEntityForName("TextWish", inManagedObjectContext: context) as NSManagedObject
            newWish.setValue(idex, forKey: "id")
            newWish.setValue(0, forKey: "type")
            newWish.setValue(str, forKey: "content")
            idex += 1
            
            
        }
        
        
        do {
            try context.save()
        } catch {
            print("Dim background error")
        }
        
    }
    
    func loadCoreData(){
        if lstBirth.count == 0
        {
            let request = NSFetchRequest(entityName: "TextWish")
            request.returnsObjectsAsFaults = false
            do {
                let appDel:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                let context:NSManagedObjectContext = appDel.managedObjectContext
                let results = try context.executeFetchRequest(request)
                if results.count > 0
                {
                    
                    for result in results
                    {
                        //context.deleteObject(result as! NSManagedObject)
                        
                        if let content = result.valueForKey("content")
                        {
                            
                            lstBirth.addObject(content)
                        }
                        
                        
                    }
                    
                    /*
                     do {
                     try context.save()
                     } catch {
                     print("Dim background error")
                     }
                     */
                }
                
            } catch {
                print("Dim background error")
            }
        }
    }
    
    
}
