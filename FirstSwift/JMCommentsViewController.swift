//
//  JMCommentsViewController.swift
//  FirstSwift
//
//  Created by iStig on 15/8/11.
//  Copyright (c) 2015年 iStig. All rights reserved.
//

import UIKit

class JMCommentsViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,JMRefreshViewDelegate {
    
    let identifier = "cell"
    var tableView:UITableView!
    var dataArray = NSMutableArray()
    var page :Int = 1
    var refreshView:JMRefreshView?
    var jokeId:String!
    
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        // Custom initialization
        self.title = "评论"
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        loadData()
        // Do any additional setup after loading the view.
    }
    
    func setupViews()
    {
        let width = self.view.frame.size.width
        let height = self.view.frame.size.height
        self.tableView = UITableView(frame:CGRectMake(0,0,width,height))
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        self.tableView.estimatedRowHeight = 100
        let nib = UINib(nibName:"JMCommentCell", bundle: nil)
        
        self.tableView.registerNib(nib, forCellReuseIdentifier: identifier)
        
        var arr =  NSBundle.mainBundle().loadNibNamed("JMRefreshView" ,owner: self, options: nil) as Array
        self.refreshView = arr[0] as? JMRefreshView
        self.refreshView!.delegate = self
        
        self.tableView.tableFooterView = self.refreshView
        self.view.addSubview(self.tableView)
    }
    
    func loadData()
    {
        let url = "http://m2.qiushibaike.com/article/\(self.jokeId)/comments?count=20&page=\(self.page)"
        self.refreshView!.startLoading()
        JMHttpRequest.requestWithUrl(url,completionHandler:{ data in
            
            if data as! NSObject == NSNull()
            {
                UIView.showAlertView("提示",message:"加载失败")
                return
            }
            
            let arr = data["items"] as! NSArray
            if arr.count  == 0
            {
                UIView.showAlertView("提示",message:"暂无新评论哦")
                self.tableView!.tableFooterView = nil
            }
            for data : AnyObject  in arr
            {
                self.dataArray.addObject(data)
            }
            self.tableView!.reloadData()
            self.refreshView!.stopLoading()
            self.page++
        })
        
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.dataArray.count;
    }
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if let cell:JMCommentCell = tableView.dequeueReusableCellWithIdentifier(identifier) as? JMCommentCell {
            let index = indexPath.row
            let data = self.dataArray[index] as! NSDictionary
            cell.data  = data
            return cell
        }
        return UITableViewCell();
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        
        struct JMSingleton {
            static var onceToken:dispatch_once_t = 0
            static var templateCell:JMCommentCell!
        }
        
        dispatch_once(&JMSingleton.onceToken,{
            JMSingleton.templateCell = tableView.dequeueReusableCellWithIdentifier(self.identifier) as? JMCommentCell
        })
        
        let index = indexPath.row
        let data = self.dataArray[index] as! NSDictionary
        
        
        let content = data.stringAttributeForKey("content")
        JMSingleton.templateCell?.contentLabel!.text = content
        
        let tempWidthConstraint:NSLayoutConstraint! = NSLayoutConstraint(item: JMSingleton.templateCell!.contentView, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: CGRectGetWidth(self.tableView!.bounds))
        JMSingleton.templateCell?.addConstraint(tempWidthConstraint)
        let height:CGFloat! = JMSingleton.templateCell?.contentView.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize).height
        return height
        
    }
    
    func refreshView(refreshView:JMRefreshView,didClickButton btn:UIButton)
    {
        loadData()
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
