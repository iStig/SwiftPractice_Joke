//
//  JMCommentCell.swift
//  FirstSwift
//
//  Created by iStig on 15/8/11.
//  Copyright (c) 2015年 iStig. All rights reserved.
//

import UIKit

class JMCommentCell: UITableViewCell {
    
    @IBOutlet var avatarView:UIImageView?
    @IBOutlet var nickLabel:UILabel?
    @IBOutlet var contentLabel:UILabel?
    @IBOutlet var floorLabel:UILabel?
    @IBOutlet var dateLabel:UILabel?

    
    
    var data :NSDictionary! {
        didSet {
            
            var user : AnyObject!  = self.data["user"]
            
            if user as! NSObject != NSNull()
            {
                var userDict = user as! NSDictionary
                self.nickLabel!.text = userDict["login"] as! NSString as String
                
                var icon : AnyObject! = userDict["icon"]
                if icon as! NSObject != NSNull()
                {
                    var userIcon = icon as! String
                    var userId =  userDict["id"] as! NSNumber
                    var userstring: NSString = "\(userId)"
                    var prefixUserId = userstring.substringToIndex(3)
                    var userImageURL = "http://pic.moumentei.com/system/avtnew/\(prefixUserId)/\(userstring)/thumb/\(userIcon)"
                    self.avatarView!.setImage(userImageURL,placeHolder: UIImage(named: "avatar.jpg"))
                }
                else
                {
                    self.avatarView!.image =  UIImage(named: "avatar.jpg")
                }
                
                var timeStamp = userDict.stringAttributeForKey("created_at")
                var date = timeStamp.dateStringFromTimestamp(timeStamp)
                self.dateLabel!.text = date
                
            }
            else
            {
                self.nickLabel!.text = "匿名"
                self.avatarView!.image =  UIImage(named: "avatar.jpg")
                self.dateLabel!.text = ""
                
            }
            var content = self.data.stringAttributeForKey("content")
            self.contentLabel!.text = content
            
            var floor = self.data.stringAttributeForKey("floor")
            self.floorLabel!.text = "\(floor)楼"
        }
    }
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
        self.contentLabel?.preferredMaxLayoutWidth = UIScreen.mainScreen().bounds.width - 8 - 8
    }
    
    override func setSelected(selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func layoutSubviews()
    {
        super.layoutSubviews()
    }
    
}
