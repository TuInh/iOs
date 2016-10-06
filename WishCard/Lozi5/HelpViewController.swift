//
//  HelpViewController.swift
//  Lozi5
//
//  Created by AnhLtv on 7/20/16.
//  Copyright © 2016 SummerLab. All rights reserved.
//

import UIKit

class HelpViewController: UIViewController ,UIScrollViewDelegate{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let widthImage = UIScreen.mainScreen().bounds.width
        let heightImage = UIScreen.mainScreen().bounds.height
        
        let frame:CGRect = CGRect.init(origin: CGPointMake(0, 0), size: CGSizeMake(widthImage, heightImage))
        let scrollView:UIScrollView = UIScrollView(frame: frame)
        let img1:UIImageView = UIImageView(image: UIImage(named: "intro1"))
        img1.frame = CGRect(origin: CGPointMake(0, 0), size: CGSizeMake(widthImage, heightImage))
        img1.contentMode = UIViewContentMode.ScaleAspectFit
        img1.backgroundColor = UIColor.whiteColor()
        scrollView.addSubview(img1)
        
        let img2:UIImageView = UIImageView(image: UIImage(named: "intro2"))
        img2.frame = CGRect(origin: CGPointMake(widthImage, 0), size: CGSizeMake(widthImage, heightImage))
        img2.contentMode = UIViewContentMode.ScaleAspectFit
        img2.backgroundColor = UIColor.whiteColor()
        scrollView.addSubview(img2)
        
        
        let img3:UIImageView = UIImageView(image: UIImage(named: "intro3"))
        img3.frame = CGRect(origin: CGPointMake(2*widthImage, 0), size: CGSizeMake(widthImage, heightImage))
        img3.contentMode = UIViewContentMode.ScaleAspectFit
        img3.backgroundColor = UIColor.whiteColor()
        scrollView.addSubview(img3)
        
        
        let img4:UIImageView = UIImageView(image: UIImage(named: "intro4"))
        img4.frame = CGRect(origin: CGPointMake(3*widthImage, 0), size: CGSizeMake(widthImage, heightImage))
        img4.contentMode = UIViewContentMode.ScaleAspectFit
        img4.backgroundColor = UIColor.whiteColor()
        scrollView.addSubview(img4)
        
        let img5:UIImageView = UIImageView(image: UIImage(named: "intro5"))
        img5.frame = CGRect(origin: CGPointMake(4*widthImage, 0), size: CGSizeMake(widthImage, heightImage))
        img5.contentMode = UIViewContentMode.ScaleAspectFit
        img5.backgroundColor = UIColor.whiteColor()
        scrollView.addSubview(img5)
        
        
        scrollView.backgroundColor = UIColor.whiteColor()
        
        scrollView.delegate = self
        scrollView.contentSize = CGSizeMake(5*widthImage, heightImage)
        self.view.addSubview(scrollView)
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
