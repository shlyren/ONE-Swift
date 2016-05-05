//
//  JENReadDetailViewController.swift
//  ONE_Swift
//
//  Created by 任玉祥 on 16/5/4.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

import UIKit

class JENReadDetailViewController : UIViewController {

    var relatedItems = [AnyObject]()
    var detail_id = ""
    /// 阅读类型
    var readType : JENReadType {
        return .Unknow
    }
    
    private var commentItems = [JENCommentItem]()
    private let relatedCellID = "JENReadRelatedCell"
    private let commentCellID = "JENCommentCell"
    
    
    
    private var headerView: JENReadDetailHeaderView?
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: self.view.bounds, style: .Grouped)
        tableView.insetB = 44
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerNib(UINib.init(nibName: "JENReadRelatedCell", bundle: nil), forCellReuseIdentifier: self.relatedCellID)
        tableView.registerNib(UINib.init(nibName: "JENCommentCell", bundle: nil), forCellReuseIdentifier: self.commentCellID)
        tableView.scrollIndicatorInsets.bottom = 44
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    deinit {
        print("\(self.classForCoder) == deinit")
    }
    

}

// MARK: - public methods
extension JENReadDetailViewController {
    func readHeaderView() -> JENReadDetailHeaderView {
        return JENReadDetailHeaderView.detailHeaderView()
    }
    
    func loadRealtedData() {
//        tableView.reloadData()
        loadCommentData()
    }
}

// MARK: - private methods
private extension JENReadDetailViewController {
    
    // MARK: 加载评论
    func loadCommentData() {
        JENLoadData.loadComment("\(readType.rawValue)/\(detail_id)/0") { (commentItems) in
            if commentItems.count > 0 {
                self.commentItems = commentItems
                self.tableView.reloadData()
                self.tableView.mj_footer = JENRefreshFooter(refreshingTarget: self, refreshingAction: #selector(JENReadDetailViewController.loadMoreCommentData))
            }
        }
    }
    
    // MARK: 更多评论
    @objc func loadMoreCommentData() {
        
        guard let comment_id = commentItems.last?.comment_id else { return }
        let url = "\(readType.rawValue)/\(detail_id)/\(comment_id)"
        JENLoadData.loadComment(url) { (responseObject) in
            if responseObject.count > 0 {
                self.commentItems += responseObject
                self.tableView.reloadData()
            }
            if responseObject.count < 20 {
                self.tableView.mj_footer.endRefreshingWithNoMoreData()
            } else {
                self.tableView.mj_footer.endRefreshing()
            }
            
        }
    }
}

// MARK: - view
private extension JENReadDetailViewController {
    func setupView() {
        view.backgroundColor = UIColor.whiteColor()
        view.addSubview(tableView)
        
        let toolBar = JENReadToolBarView.toolBarView(readType, detail_id: detail_id)
        view.addSubview(toolBar)
        
        headerView = self.readHeaderView()
        tableView.tableHeaderView = headerView
        headerView!.detail_id = detail_id
        headerView!.readType = readType
        headerView!.contentChang {[weak self] (height, num) in
            self!.headerView!.height = height!
            self!.tableView.tableHeaderView = self!.headerView
            toolBar.setToolBarTitle(num.praisenum, commentnum: num.sharenum, sharenum: num.commentnum)
            self!.loadRealtedData()
        }
    }
}


// MARK: - table view datasource
extension JENReadDetailViewController : UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        tableView.tableViewWithNoData(nil, rowCount: commentItems.count)
        if relatedItems.count > 0 {return 2}
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 && relatedItems.count > 0 {return relatedItems.count }
        return commentItems.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        tableView.tableViewSetExtraCellLineHidden()
        
        if relatedItems.count > 0 && indexPath.section == 0 {
            let realtedCell = tableView.dequeueReusableCellWithIdentifier(relatedCellID) as! JENReadRelatedCell
            realtedCell.readType = readType
            realtedCell.relatedItem = relatedItems[indexPath.row] as! NSObject
            
            return realtedCell
        }
        
        let commentCell = tableView.dequeueReusableCellWithIdentifier(commentCellID) as! JENCommentCell
        commentCell.commentItem = commentItems[indexPath.row]
        return commentCell
    }
}

// MARK: - table view delegate
extension JENReadDetailViewController : UITableViewDelegate {
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if relatedItems.count > 0 && section == 0 {
            return JENExtensionView.relatedSectionHeaderView()
        }
        if commentItems.count > 0 {
            return JENExtensionView.commentSectionHeaderView()
        }
        return nil
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if relatedItems.count > 0 && indexPath.section == 0 {
            let relatedCell = tableView.dequeueReusableCellWithIdentifier(relatedCellID) as! JENReadRelatedCell
            relatedCell.readType = readType
            relatedCell.relatedItem = relatedItems[indexPath.row] as! NSObject
            return relatedCell.rowHeight
        }
        
        let commentCell = tableView.dequeueReusableCellWithIdentifier(commentCellID) as! JENCommentCell
        commentCell.commentItem = commentItems[indexPath.row]
        return commentCell.rowHeight
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if commentItems.count == 0 {
            return JENFloatZero
        }
        return JENTitleViewH
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return JENFloatZero
    }
}





