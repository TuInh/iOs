//
//  CustomTabBarViewController.swift
//  Lozi5
//
//  Created by AnhLtv on 4/10/16.
//  Copyright © 2016 SummerLab. All rights reserved.
//

import UIKit

class CustomTabBarViewController: UITabBarController {

    
    @IBOutlet var myTabBar: UITabBar!
    override func viewDidLoad() {
        super.viewDidLoad()
    myTabBar.tintColor = UIColor(red: 26.0/255.0, green: 132.0/255.0, blue: 70.0/255.0, alpha:1.0)
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
