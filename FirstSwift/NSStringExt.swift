//
//  NSStringExt.swift
//  FirstSwift
//
//  Created by iStig on 15/8/10.
//  Copyright (c) 2015年 iStig. All rights reserved.
//

import Foundation
import UIKit
extension String {
 
    func stringHeightWith(fontSize:CGFloat,width:CGFloat)->CGFloat
    {
    var font = UIFont.systemFontOfSize(fontSize)
        var size = CGSizeMake(width, CGFloat.max)
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = NSLineBreakMode.ByWordWrapping
        var attributes = [NSFontAttributeName:font,NSParagraphStyleAttributeName:paragraphStyle.copy()]
        var text = self as NSString
        var rect = text.boundingRectWithSize(size, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: attributes, context: nil)
        return rect.size.height
    }
    
    func dateStringFromTimestamp(timeStamp:NSString)->String {
        var ts = timeStamp.doubleValue
        var formatter = NSDateFormatter ()
        formatter.dateFormat = "yyyy年MM月dd日 HH:MM:ss"
        var date = NSDate(timeIntervalSince1970: ts)
        return formatter.stringFromDate(date)
    }
}
