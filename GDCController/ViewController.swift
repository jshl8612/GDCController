//
//  ViewController.swift
//  GDCController
//
//  Created by Jiang Steven on 15/8/15.
//  Copyright (c) 2015年 Jiang Steven. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func testAction(sender: AnyObject) {
        
        testGDCController(text: "Process A")
        
        NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: Selector("testGDCControllerTimer:"), userInfo: "Process B", repeats: false)
    }

    
    func testGDCController(#text : String) {
        let current = NSDate()
        
        GDCController.schedule(processBlock: { () -> Void in
            println("\(NSDate()) : \(text) Start")
            //Wait for 6 seconds
            while(NSDate().timeIntervalSinceDate(current) < 6) {
                
            }
        }, finishBlock: { () -> Void in
            println("\(NSDate()) : \(text) Finished")
        }, shouldCancel: true)
        
    }
    
    func testGDCControllerTimer(sender : NSTimer) {
        
        if let text = sender.userInfo?.description {
            testGDCController(text: text)
        }
    }
}

