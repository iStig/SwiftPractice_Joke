//
//  JMImageViewController.swift
//  FirstSwift
//
//  Created by iStig on 15/8/11.
//  Copyright (c) 2015年 iStig. All rights reserved.
//

import UIKit

class JMImageViewController: UIViewController {
    var imageUrl:String = ""
    var imageZoomingView:JMImageZoomingView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        // Do any additional setup after loading the view.
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.title = "图片"
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")

    }
    
    func setupViews () {
//        var effect:UIBlurEffect = UIBlurEffect(style: UIBlurEffectStyle.Light)
//        var blurView:UIVisualEffectView = UIVisualEffectView(effect: effect)
//        blurView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)
//        blurView.backgroundColor = UIColor.whiteColor()
//        self.view.addSubview(blurView)
        self.view.backgroundColor = UIColor.whiteColor()
        self.imageZoomingView = JMImageZoomingView(frame: self.view.frame)
        self.imageZoomingView.imageUrl = self.imageUrl
        self.view.addSubview(self.imageZoomingView)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
