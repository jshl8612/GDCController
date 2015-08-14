# GDCController
A GDC controller that could cancel former queue's finish execution.


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
    
2015-08-14 18:55:18 +0000 : Process A Start
2015-08-14 18:55:21 +0000 : Process B Start
2015-08-14 18:55:24 +0000 : Cancel
2015-08-14 18:55:27 +0000 : Process B Finished
