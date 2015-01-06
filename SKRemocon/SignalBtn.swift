//
//  SignalBtn.swift
//  SKRemocon
//
//  Created by kayama on 2015/01/06.
//  Copyright (c) 2015年 kayama. All rights reserved.
//

import UIKit

@IBDesignable class SignalBtn: UIButton {


    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        
        self.addTarget(self, action: "pushAction:", forControlEvents: UIControlEvents.TouchDown)
    }
    
    // なぜか必要
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func pushAction(btn: SignalBtn)
    {
        // AppDelegate
        let ad = UIApplication.sharedApplication().delegate as AppDelegate
        
        let signal = ad.m_IRSignal.getIRSignal(signalName)
        
        // シグナル送信
        signal.sendWithCompletion( {(NSError) ->Void in println(self.signalName + " send complete")} )
    }
    
    @IBInspectable var signalName: String = "not set error" {
    
        didSet {
            
        }
    }
    
    @IBInspectable var color: UIColor = UIColor.blackColor() {
        didSet {
            layer.borderWidth = 2.0
            layer.cornerRadius = 3.5
            layer.borderColor = color.CGColor
            self.setTitleColor(UIColor.blackColor(), forState: .Normal)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }


}
