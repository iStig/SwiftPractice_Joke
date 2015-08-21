//
//  FileUtility.swift
//  FirstSwift
//
//  Created by iStig on 15/8/10.
//  Copyright (c) 2015年 iStig. All rights reserved.
//

import UIKit

class FileUtility: NSObject {
    class func cachePath(fileName:String)->String  {
    var arr = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        var path = arr[0] as! String
        return"\(path)/\(fileName)"
    }
    
    class func imageCacheToPath(path:String,image:NSData)->Bool {
    return image.writeToFile(path, atomically: true)
    }
    
    class func imageDataFromPath(path:String)->AnyObject {
    var exist = NSFileManager.defaultManager().fileExistsAtPath(path)
        if exist {
        var data = NSData(contentsOfFile: path)
            var img = UIImage(contentsOfFile: path)
            var url:NSURL? = NSURL.fileURLWithPath(path)
            var dd = NSFileManager.defaultManager().contentsAtPath(url!.path!)
            var jpg = UIImage(data: dd!)
            
            if img != nil {
                return img!
            } else {
                return NSNull()
            }
        }
        return NSNull()
    }
}
