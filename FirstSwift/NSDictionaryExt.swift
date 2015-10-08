//
//  NSDictionaryExt.swift
//  FirstSwift
//
//  Created by iStig on 15/8/10.
//  Copyright (c) 2015年 iStig. All rights reserved.
//

import UIKit

extension NSDictionary {
    
    func stringAttributeForKey(key:String)->String {
        let obj:AnyObject? = self[key]
        if let aa = obj as? NSObject {
        
        }else {
           return ""
        }
        
        if obj!.isKindOfClass(NSNumber)
        {
        let num = obj as! NSNumber
            return num.stringValue
        }
        
        if let bb = obj as? String
        {
            return obj as!String
        }
        
        return ""
    }
}
