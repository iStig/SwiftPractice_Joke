//
//  UIImageViewWebExt.swift
//  FirstSwift
//
//  Created by iStig on 15/8/10.
//  Copyright (c) 2015年 iStig. All rights reserved.
//

import UIKit
import Foundation

extension UIImageView {
    func setImage(urlString:String, placeHolder:UIImage!){
        var url = NSURL(string: urlString)
        var cacheFilename = url?.lastPathComponent
        var cachePath = FileUtility.cachePath(cacheFilename!)

        var image : AnyObject = FileUtility.imageDataFromPath(cachePath)
        if image as! NSObject != NSNull()
        {
            self.image = image as? UIImage
        }
        else
        {
            var req = NSURLRequest(URL: url!)
            var queue = NSOperationQueue();
            NSURLConnection.sendAsynchronousRequest(req, queue: queue, completionHandler: { response, data, error in
                if (error != nil)
                {
                    dispatch_async(dispatch_get_main_queue(),
                        {
                            print(error, terminator: "")
                            self.image = placeHolder
                    })
                }
                else
                {
                    dispatch_async(dispatch_get_main_queue(),
                        {
                            
                            var image = UIImage(data: data!)
                            if (image == nil)
                            {
                                let jsonData = (try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers)) as! NSDictionary
                                
                                if let err:String? = jsonData["error"] as? String {
                                    //println("\(err)")
                                    print("url fail=\(urlString)");
                                }
                                //println("img is nil,path=\(cachePath)")
                                self.image = placeHolder
                            }
                            else
                            {
                                self.image = image
                                var bIsSuccess = FileUtility.imageCacheToPath(cachePath,image:data!)
                                if !bIsSuccess
                                {
                                    print("*******cache fail,path=\(cachePath)")
                                }
                            }
                    })
                }
            })
            
        }

    }
}
