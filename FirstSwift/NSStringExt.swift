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
    let font = UIFont.systemFontOfSize(fontSize)
        let size = CGSizeMake(width, CGFloat.max)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = NSLineBreakMode.ByWordWrapping
        let attributes = [NSFontAttributeName:font,NSParagraphStyleAttributeName:paragraphStyle.copy()]
        let text = self as NSString
        let rect = text.boundingRectWithSize(size, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: attributes, context: nil)
        return rect.size.height
    }
    
    func dateStringFromTimestamp(timeStamp:NSString)->String {
        let ts = timeStamp.doubleValue
        let formatter = NSDateFormatter ()
        formatter.dateFormat = "yyyy年MM月dd日 HH:MM:ss"
        let date = NSDate(timeIntervalSince1970: ts)
        return formatter.stringFromDate(date)
    }
}
