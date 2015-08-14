//
//  GDCController.swift
//  buylist
//
//  Created by Jiang Steven on 15/8/15.
//  Copyright (c) 2015年 Jiang Steven. All rights reserved.
//

import UIKit

var globalController : GDCController? = nil
var globalQueue : dispatch_queue_t? = nil

class GDCController: NSObject {
   
    var shouldCancel : Bool = false
    var queue : dispatch_queue_t = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
    
    /**
    Schedule a new dispatch and cancel/continue former dispatch
    processBlock : processBlock
    finishBlock : finishBlock
    shouldCancel : should cancel former queue's finishBlock
    */
    
    class func schedule(#processBlock: ()-> Void, finishBlock: ()-> Void, shouldCancel:Bool) {
        
        if globalController != nil {
            globalController!.shouldCancel = shouldCancel
            globalController = nil
        }
        
        if globalQueue != nil {
            
            dispatch_suspend(globalQueue!)
            globalQueue = nil
        }
        
        globalController = GDCController()
        globalQueue = globalController!.queue
        
        globalController!.dispatch(processBlock: processBlock, finishBlock: finishBlock)
        
    }
    
    /**
    Dispatch a processBlock & a finishBlock
    processBlock : processBlock
    finishBlock : finishBlock
    */
    func dispatch(#processBlock: ()->Void, finishBlock: ()-> Void) {
        
        let group = dispatch_group_create()
        
        dispatch_group_async(group, queue) {
            processBlock()
        }
        
        dispatch_group_notify(group, dispatch_get_main_queue()) {
            // This block will be executed when all tasks are complete
            
            if !self.shouldCancel {
                finishBlock()
            }else {
                println("\(NSDate()) : Cancel")
            }
        }
    }
}
