//
//  JMRefreshView.swift
//  FirstSwift
//
//  Created by iStig on 15/8/10.
//  Copyright (c) 2015年 iStig. All rights reserved.
//

import UIKit
protocol JMRefreshViewDelegate {
    func refreshView(refreshView:JMRefreshView, didClickButton btn:UIButton)
}

class JMRefreshView: UIView {
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    var delegate:JMRefreshViewDelegate!
    @IBAction func buttonClicked(sender: UIButton) {
        self.delegate.refreshView(self, didClickButton: sender)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.indicator!.hidden = true
    }
    
    func startLoading()
    {
    self.button!.setTitle("", forState: UIControlState.Normal)
        self.indicator.hidden = false
        self.indicator.startAnimating()
    }
    
    func stopLoading() {
        self.button.setTitle("点击加载更多", forState: UIControlState.Normal)
        self.indicator.hidden = true
        self.indicator.stopAnimating()
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
