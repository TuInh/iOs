//
//  TextDetailViewController.swift
//  Lozi5
//
//  Created by AnhLtv on 4/11/16.
//  Copyright © 2016 SummerLab. All rights reserved.
//

import UIKit

class TextDetailViewController: UIViewController, UITableViewDelegate {
    
    
    @IBOutlet var Backbtn: UIButton!
    @IBOutlet var txtTitle: UILabel!
    @IBOutlet var btnBackDetail: UIButton!
    @IBOutlet var view1: UIView!
    @IBOutlet var tableviewDetail: UITableView!
    var index = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableviewDetail.estimatedRowHeight = 250
        view1.backgroundColor = UIColor(red: 54.0/255.0, green: 152.0/255.0, blue: 102.0/255.0, alpha:1.0)
        Backbtn.titleLabel!.font =  UIFont(name: "Helvertica", size: 18)
        Backbtn.setTitleColor( UIColor(red:164.0/255.0, green: 250.0/255.0, blue: 255.0/255.0, alpha:1.0)
            , forState: .Normal)
        Backbtn.titleLabel?.font = UIFont.boldSystemFontOfSize(18)
        txtTitle.textColor = UIColor.whiteColor()
        txtTitle.font = UIFont(name: "Helvertica", size: 20)
        txtTitle.font = UIFont.boldSystemFontOfSize(20)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 20;
    }
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let v:UIView = UIView()
        v.backgroundColor = UIColor(red: 54.0/255.0, green: 152.0/255.0, blue: 102.0/255.0, alpha:1.0)
        return v
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return UITableViewAutomaticDimension
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        if index == 0
        {
            return lstBirth.count
        }
        else
        {
            return lstBirth.count
        }
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 1
        
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cellIdentifier = "TextDetail"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! TextDetailTableViewCell
        cell.txtContent.text = lstBirth.objectAtIndex(indexPath.section) as! String
        cell.txtContent.numberOfLines = 0
        cell.txtContent.lineBreakMode = NSLineBreakMode.ByWordWrapping
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        return cell
    }
    
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]?
    {
        let share = UITableViewRowAction(style: .Normal, title: "Share") { (action, index) in
            self.actionForText(1, atIndex: index.section)
            
        }
        share.backgroundColor = UIColor.lightGrayColor()
        
        let copy = UITableViewRowAction(style: .Normal, title: "Copy") { (action, index) in
            self.actionForText(2, atIndex: index.section)
        }
        copy.backgroundColor = UIColor.orangeColor()
        return [copy,share]
    }
    // Function for share or copy text when swipe uitableview from left to right
    func actionForText(type:Int, atIndex index:Int)
    {
        let textToShare:String = lstBirth.objectAtIndex(index) as! String
        if type == 1
        {
            
            let vc = UIActivityViewController(activityItems: [textToShare], applicationActivities: nil)
            self.presentViewController(vc, animated: true, completion: nil)
        }
        if type == 2
        {
            let toastLabel = UILabel()
            toastLabel.frame = CGRectMake(0,UIScreen.mainScreen().bounds.height/2, UIScreen.mainScreen().bounds.width,UIScreen.mainScreen().bounds.height)
            toastLabel.text = "Text is already copied on clipboard"
            toastLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
            toastLabel.font = UIFont.boldSystemFontOfSize(toastLabel.font.pointSize)
            toastLabel.sizeToFit()
            toastLabel.layer.cornerRadius = 10
            toastLabel.layer.masksToBounds = true
            toastLabel.alpha = 1
            toastLabel.textColor = UIColor.blackColor()
            toastLabel.textAlignment = NSTextAlignment.Center
            toastLabel.frame = CGRectMake(UIScreen.mainScreen().bounds.width/2-toastLabel.frame.size.width*1.1/2, UIScreen.mainScreen().bounds.height/2,toastLabel.frame.size.width*1.1 , toastLabel.frame.size.height*1.6)
            self.view .addSubview(toastLabel)
            toastLabel.backgroundColor = UIColor.lightGrayColor()
            UIView.animateWithDuration(3, delay: 0.01, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                toastLabel.alpha = 0;
                }, completion: nil)
            
            
            let pasteBoard:UIPasteboard = UIPasteboard.generalPasteboard()
            pasteBoard.string = textToShare
            
        }
    }
}
