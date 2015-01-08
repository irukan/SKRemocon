//
//  ViewController.swift
//  SKRemocon
//
//  Created by kayama on 2015/01/06.
//  Copyright (c) 2015年 kayama. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //回転禁止
    override func shouldAutorotate() -> Bool {
        return false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func close(sender: AnyObject)
    {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        
        // addSubViewしたもの一覧
        let subViews = self.view.subviews
        
        // 一番下のポジション
        var bottomPosition: CGFloat = 0.0
        var bottomHeight : CGFloat = 0.0
        
        for view in subViews
        {
            let tmpPosY = (view as UIView).frame.origin.y
            if (tmpPosY > bottomPosition)
            {
                bottomPosition = tmpPosY
                bottomHeight = view.frame.size.height
            }
        }
        
        (self.view as UIScrollView).contentSize = CGSizeMake(self.view.frame.size.width, bottomPosition + bottomHeight + 10)
    }

}

