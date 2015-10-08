//
//  JMJokeCell.swift
//  FirstSwift
//
//  Created by iStig on 15/8/10.
//  Copyright (c) 2015年 iStig. All rights reserved.
//

import UIKit

class JMJokeCell: UITableViewCell {
    @IBOutlet weak var avaterView: UIImageView!
    @IBOutlet weak var pictureView: UIImageView?
    @IBOutlet weak var nickLabel: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var dislikeLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var bottomView: UIView!
    var largeImageUrl:String = ""
    @IBOutlet weak var heightConstraints: NSLayoutConstraint!
//    @IBOutlet weak var verticalSpace: NSLayoutConstraint!
    var data : NSDictionary!{
    
        didSet {
        
            let user:AnyObject? = self.data["user"]
            if let userDictOp:NSDictionary = user as? NSDictionary {
                let userDict = userDictOp
                self.nickLabel.text = userDict["login"] as! String?
                
                let icon:AnyObject? = userDict["icon"]
                if icon as! NSObject != NSNull()
                {
                    let userIcon = icon as! String
                    let userId = userDict["id"] as! NSNumber
                    let userstring:NSString = "\(userId)"
                    let prefixUserID = userstring.substringToIndex(userstring.length - 4)
                    let userImageUrl =  "http://pic.qiushibaike.com/system/avtnew/\(prefixUserID)/\(userstring)/medium/\(userIcon)"
                    self.avaterView.setImage(userImageUrl, placeHolder: UIImage(named: "avatar.jpg"))
                }
                else {
                    self.avaterView.image = UIImage(named: "avatar.jpg")
                }
            }
            else
            {
                self.nickLabel.text = "匿名"
                self.avaterView.image = UIImage(named: "avatar.jpg")
            }
            
            let content = self.data.stringAttributeForKey("content")
 
            self.contentLabel.text = content
            
            let imgSrc = self.data.stringAttributeForKey("image") as NSString
            if imgSrc.length == 0 {
//                self.pictureView!.image = nil
//                self.pictureView!.hidden = true
                self.heightConstraints.constant = 0
                
//                self.contentLabel.addConstraint(self.verticalSpace);
                print(content, terminator: "")
            }else {
                let imageID = self.data.stringAttributeForKey("id") as NSString
                let prefiximageID = imageID.substringToIndex(imageID.length - 4)
//                self.pictureView!.hidden = false
                self.heightConstraints.constant = 112
                
//                self.contentLabel.removeConstraint(self.verticalSpace);
                let imagURL = "http://pic.qiushibaike.com/system/pictures/\(prefiximageID)/\(imageID)/small/\(imgSrc)"
                self.pictureView!.setImage(imagURL, placeHolder: UIImage(named: "avatar.jpg"))
                self.largeImageUrl = "http://pic.qiushibaike.com/system/pictures/\(prefiximageID)/\(imageID)/medium/\(imgSrc)"
                
                print(content, terminator: "")
                print(imagURL, terminator: "")
            }
            
            let votes:AnyObject! = self.data["votes"]
            if votes as! NSObject == NSNull()
            {
                self.likeLabel.text = "顶(0)"
                self.dislikeLabel.text = "踩(0)"
            }else {
                let votesDict = votes as! NSDictionary
                let like = votesDict.stringAttributeForKey("up") as String
                let dislike = votesDict.stringAttributeForKey("down") as String
                self.likeLabel.text = "顶\(like)"
                self.dislikeLabel.text = "踩\(dislike)"
            }
            let commentCount = self.data.stringAttributeForKey("comments_count") as String
            self.commentLabel.text = "评论\(commentCount)"
        }
    }

    
    @IBOutlet weak var contentLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = UITableViewCellSelectionStyle.None
        let tap =  UITapGestureRecognizer(target: self, action: "imageViewTapped:")
        self.pictureView!.addGestureRecognizer(tap)
       self.contentLabel?.preferredMaxLayoutWidth = UIScreen.mainScreen().bounds.width - 8 - 8
    }

    func imageViewTapped(sender:UITapGestureRecognizer) {
        NSNotificationCenter.defaultCenter().postNotificationName("imageViewTapped", object: self.largeImageUrl)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
