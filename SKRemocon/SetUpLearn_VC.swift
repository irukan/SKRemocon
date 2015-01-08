//
//  SetUpLearn_VC.swift
//  iRKit
//
//  Created by kayama on 2015/01/05.
//  Copyright (c) 2015年 kayama. All rights reserved.
//

import UIKit

class SetUpLearn_VC: UIViewController, IRNewPeripheralViewControllerDelegate, IRNewSignalViewControllerDelegate {

    var ad: AppDelegate!
    var m_signal: IRSignal!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //AppDelegate
        ad = UIApplication.sharedApplication().delegate as AppDelegate
        
        
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        setUp()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func pushLearn(id : UIButton)
    {
        learnView()
    }
    
    // IRKitが見つかった時
    func newPeripheralViewController(viewController: IRNewPeripheralViewController!, didFinishWithPeripheral peripheral: IRPeripheral!) {
        
        println("dismiss")
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func setUp()
    {
        if ( IRKit.sharedInstance().countOfReadyPeripherals == 0)
        {
            let findVC : IRNewPeripheralViewController = IRNewPeripheralViewController()
            findVC.delegate = self
            
            self.presentViewController(findVC, animated: true, completion: nil)
        }
    }
    
    // 学習が完了した時
    func newSignalViewController(viewController: IRNewSignalViewController!, didFinishWithSignal signal: IRSignal!)
    {
        if ((signal) != nil)
        {
            m_signal = signal
            
            // ファイルに書き込み
            ad.m_IRSignal.writeToDataFile(signal)
        }
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    func learnView()
    {
        let signalVC : IRNewSignalViewController = IRNewSignalViewController()
        signalVC.delegate = self
        
        self.presentViewController(signalVC, animated: true, completion: nil)
    }
    
    @IBAction func close(sender: AnyObject)
    {
        self.dismissViewControllerAnimated(true, completion: nil)
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
