//
//  JMAutoResizeCell.swift
//  FirstSwift
//
//  Created by iStig on 15/8/12.
//  Copyright (c) 2015年 iStig. All rights reserved.
//

import UIKit

class JMAutoResizeCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var content: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        updateFonts()
            self.content.preferredMaxLayoutWidth = UIScreen.mainScreen().bounds.width - 15 - 15 ;
    }
//    func updateFonts() {
//        self.title.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
//        self.content.font = UIFont.preferredFontForTextStyle(UIFontTextStyleCaption2)
//    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
