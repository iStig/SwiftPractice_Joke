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
            
            let user : AnyObject!  = self.data["user"]
            
            if user as! NSObject != NSNull()
            {
                let userDict = user as! NSDictionary
                self.nickLabel!.text = userDict["login"] as! NSString as String
                
                let icon : AnyObject! = userDict["icon"]
                if icon as! NSObject != NSNull()
                {
                    let userIcon = icon as! String
                    let userId =  userDict["id"] as! NSNumber
                    let userstring: NSString = "\(userId)"
                    let prefixUserId = userstring.substringToIndex(3)
                    let userImageURL = "http://pic.moumentei.com/system/avtnew/\(prefixUserId)/\(userstring)/thumb/\(userIcon)"
                    self.avatarView!.setImage(userImageURL,placeHolder: UIImage(named: "avatar.jpg"))
                }
                else
                {
                    self.avatarView!.image =  UIImage(named: "avatar.jpg")
                }
                
                let timeStamp = userDict.stringAttributeForKey("created_at")
                let date = timeStamp.dateStringFromTimestamp(timeStamp)
                self.dateLabel!.text = date
                
            }
            else
            {
                self.nickLabel!.text = "匿名"
                self.avatarView!.image =  UIImage(named: "avatar.jpg")
                self.dateLabel!.text = ""
                
            }
            let content = self.data.stringAttributeForKey("content")
            self.contentLabel!.text = content
            
            let floor = self.data.stringAttributeForKey("floor")
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
