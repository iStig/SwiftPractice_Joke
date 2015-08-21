//
//  JMHttpRequest.swift
//  FirstSwift
//
//  Created by iStig on 15/8/10.
//  Copyright (c) 2015年 iStig. All rights reserved.
//

import UIKit

class JMHttpRequest: NSObject {
    override init() {
        super.init();
    }
    
    
    class func requestWithUrl(urlString:String,completionHandler:(data:AnyObject)->Void){
        var URL = NSURL(string: urlString)
        var req = NSURLRequest(URL: URL!)
        var queue = NSOperationQueue()
        NSURLConnection.sendAsynchronousRequest(req, queue: queue, completionHandler: {response,data,error in
            if (error != nil)
            {
                dispatch_async(dispatch_get_main_queue(),
                    {
                        println(error)
                        completionHandler(data:NSNull())
                })
            }
            else {
            
                let jsonData = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as! NSDictionary
                
                dispatch_async(dispatch_get_main_queue(),
                    {
                        completionHandler(data:jsonData)
                        
                })
            }
        
        })
    }
}


