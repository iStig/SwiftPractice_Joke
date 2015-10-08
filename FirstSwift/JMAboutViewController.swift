//
//  JMAboutViewController.swift
//  FirstSwift
//
//  Created by iStig on 15/8/7.
//  Copyright (c) 2015年 iStig. All rights reserved.
//

import UIKit

class JMAboutViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    let kCellIdentifier = "cell"
    var tableView:UITableView!
    var model:Model = Model(populated: true)
    var offscreenCells:NSDictionary = NSDictionary()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    override func viewWillAppear(animated: Bool) {
//        super.viewWillAppear(animated)
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: "contentSizeCategoryChanged:", name: UIContentSizeCategoryDidChangeNotification, object: nil)
//    }
//    
//    override func viewWillDisappear(animated: Bool) {
//        super.viewWillDisappear(animated)
//        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIContentSizeCategoryDidChangeNotification, object: nil)
//    }
    
    func contentSizeCategoryChanged(noti:NSNotification) {
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        // Do any additional setup after loading the view.
    }

    func setupViews() {
        
        let width = UIScreen.mainScreen().bounds.size.width
        let height = UIScreen.mainScreen().bounds.size.height
        self.tableView = UITableView(frame: CGRectMake(0, 64, width, height-64-49), style: UITableViewStyle.Plain)
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.registerNib(UINib(nibName: "JMAutoResizeCell", bundle: nil), forCellReuseIdentifier:kCellIdentifier)
//        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 65
        self.tableView.allowsSelection = false
        self.view.addSubview(self.tableView)
    }
    
   // MARK: - UITableViewDataSource && UITableViewDelegate
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(self.model.dataArray.count)
        return 5
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell:JMAutoResizeCell = tableView.dequeueReusableCellWithIdentifier(kCellIdentifier) as? JMAutoResizeCell {
            
//            cell.updateFonts()
            
            let modelItem = model.dataArray[indexPath.row]
            cell.title.text = modelItem.title
            cell.content.text = modelItem.body
//            cell.setNeedsUpdateConstraints()
//            cell.updateConstraintsIfNeeded()
            return cell
        }
        
        assert(false, "The dequeued table view cell was of an unknown type!")
        return UITableViewCell()
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        struct JMSingleton {
        static var onceToken:dispatch_once_t = 0
        static var templateCell:JMAutoResizeCell? = nil
        }
        
        dispatch_once(&JMSingleton.onceToken,{
          JMSingleton.templateCell = tableView.dequeueReusableCellWithIdentifier(self.kCellIdentifier) as? JMAutoResizeCell
        })
        
        let modelItem = model.dataArray[indexPath.row]

        JMSingleton.templateCell?.content.text = modelItem.body
        JMSingleton.templateCell?.title.text = modelItem.title
        

        
        let tempWidthConstraint:NSLayoutConstraint! = NSLayoutConstraint(item: JMSingleton.templateCell!.contentView, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: CGRectGetWidth(self.tableView.bounds))
        JMSingleton.templateCell?.addConstraint(tempWidthConstraint)
        let height:CGFloat! = JMSingleton.templateCell?.contentView.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize).height
//        JMSingleton.templateCell?.removeConstraint(tempWidthConstraint)
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
