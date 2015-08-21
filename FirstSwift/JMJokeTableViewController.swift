//
//  JMJokeTableViewController.swift
//  FirstSwift
//
//  Created by iStig on 15/8/10.
//  Copyright (c) 2015年 iStig. All rights reserved.
//

import UIKit

enum JMJokeTableViewControllerType:NSInteger {
    case HotJoke
    case NewsJoke
    case ImageTruth
}

class JMJokeTableViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,JMRefreshViewDelegate {
    let identifier = "cell"
    var jokeType:JMJokeTableViewControllerType = .HotJoke
    var tableView:UITableView?
    var dataArray:NSMutableArray = NSMutableArray()
    var page:Int = 1
    var refreshView:JMRefreshView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        loadData()
        // Do any additional setup after loading the view.
    }
    
    func setupViews() {
        var width = self.view.frame.size.width
        var height = self.view.frame.size.height
        self.tableView = UITableView(frame: CGRectMake(0, 64, width, height-64-49))
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.tableView?.separatorStyle = UITableViewCellSeparatorStyle.None
        self.view.addSubview(self.tableView!)
        
        var nib = UINib(nibName:"JMJokeCell", bundle: nil)
        self.tableView?.registerNib(nib, forCellReuseIdentifier: identifier)
        
        var arr = NSBundle.mainBundle().loadNibNamed("JMRefreshView", owner: self, options: nil) as NSArray
        self.refreshView = arr[0] as? JMRefreshView
        self.refreshView?.delegate = self
        self.tableView?.tableFooterView = self.refreshView
        
    }
    
    func loadData() {
        var url = urlString()
        self.refreshView?.startLoading()
        JMHttpRequest.requestWithUrl(url, completionHandler: { data  in
            if data as! NSObject == NSNull() {
                UIView.showAlertView("提示",message:"加载失败")
                return
            }
            
            var arr = data["items"] as! NSArray
            for data:AnyObject in arr
            {
            self.dataArray.addObject(data)
            }
            self.tableView?.reloadData()
            self.refreshView?.stopLoading()
            self.page++
        })
    }
    
    func urlString() -> String {
        if jokeType == .HotJoke {
            return "http://m2.qiushibaike.com/article/list/suggest?count=20&page=\(page)"
        }
        else if jokeType == .NewsJoke {
            return "http://m2.qiushibaike.com/article/list/latest?count=20&page=\(page)"
        }
        else {
            return "http://m2.qiushibaike.com/article/list/imgrank?count=20&page=\(page)"
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "imageViewTapped", object: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "imageViewTapped:", name: "imageViewTapped", object: nil)
    }
    
    func imageViewTapped(noti:NSNotification) {
    var imageUrl = noti.object as! String
    println(imageUrl)
        var imgVC = JMImageViewController(nibName: nil, bundle: nil)
        imgVC.imageUrl = imageUrl
        self.navigationController?.pushViewController(imgVC, animated: true)
    }
    
    func refreshView(refreshView: JMRefreshView, didClickButton btn: UIButton) {
        loadData()
    }
    
    //MARK: TableViewDatasource && TableViewDelegate
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as? JMJokeCell
        var index = indexPath.row
        var data = self.dataArray[index] as! NSDictionary
        cell!.data = data
        println("      index:\(index)")
//        cell!.setNeedsUpdateConstraints()
//        cell!.updateConstraintsIfNeeded()
        
        return cell!
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var index = indexPath.row
        var data = self.dataArray[index] as! NSDictionary
        var commentsVC = JMCommentsViewController(nibName :nil, bundle: nil)
        commentsVC.jokeId = data.stringAttributeForKey("id")
        self.navigationController!.pushViewController(commentsVC, animated: true)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        struct JMSingleton {
            static var onceToken:dispatch_once_t = 0
            static var templateCell:JMJokeCell!
        }
        
        dispatch_once(&JMSingleton.onceToken,{
            JMSingleton.templateCell = tableView.dequeueReusableCellWithIdentifier(self.identifier) as? JMJokeCell
        })
        
        var index = indexPath.row
        var data = self.dataArray[index] as! NSDictionary
        
        
        var content = data.stringAttributeForKey("content")
        JMSingleton.templateCell?.contentLabel!.text = content
        
        var imgSrc = data.stringAttributeForKey("image") as NSString
        
        
        if imgSrc.length == 0 {
            JMSingleton.templateCell?.heightConstraints.constant = 0
        }
        else
        {
            JMSingleton.templateCell?.heightConstraints.constant = 112
        }

        
        var tempWidthConstraint:NSLayoutConstraint! = NSLayoutConstraint(item: JMSingleton.templateCell!.contentView, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: CGRectGetWidth(self.tableView!.bounds))
        JMSingleton.templateCell?.addConstraint(tempWidthConstraint)
        var height:CGFloat! = JMSingleton.templateCell?.contentView.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize).height
        
  
        
        return height
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
