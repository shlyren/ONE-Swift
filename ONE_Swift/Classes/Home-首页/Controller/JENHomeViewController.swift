//
//  JENHomeViewController.swift
//  ONE_Swift
//
//  Created by 任玉祥 on 16/4/27.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

import UIKit

class JENHomeViewController: UITableViewController {

    var urlString = "more/0"
    private let homeTableCell = "JENHomeTableCell"
    private var homeSubtotal = NSArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupView()
        
        loadData()
    }
    
    // MARK:- 初始化view
    private func setupView() {
        tableView.registerNib(UINib(nibName: "JENHomeTableCell", bundle: nil), forCellReuseIdentifier: homeTableCell)
        tableView.rowHeight = 105.0
        tableView.separatorStyle = .None

        
        if navigationController?.childViewControllers.count == 1 {
            let footerView = JENTableFooterView().footerView()
            footerView.footerBth.addTarget(self, action: "footerBtnClick", forControlEvents: .TouchUpInside)
            footerView.frame.size.height = 54
            tableView.tableFooterView = footerView
        } else {
            let footerView = UIView()
            footerView.frame.size.height = 10
            tableView.tableFooterView = footerView
        }
    }
    
    // MARK:- 加载数据
    private func loadData() {
        JENLoadData.shareInstance.loadHomeSubtotal(urlString) { (responseObject) -> () in
            
            if responseObject.count > 0 {
                self.homeSubtotal = responseObject
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK:-  按钮点击事件
    @objc func footerBtnClick() {
        let homePastListVc = JENHomePastListViewController()
        homePastListVc.endMonth = "2012-10"
        
        navigationController?.pushViewController(homePastListVc, animated: true)
    }
    
    // MARK:- tableview data source
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.homeSubtotal.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(homeTableCell) as! JENHomeTableCell
        cell.homeSubTotal = homeSubtotal[indexPath.row] as! JENHomeSubTotalItem
        return cell
    }
    
    
    // MARK:- table view delegate
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let homeDetailVc = JENHomeDetailViewController()
        homeDetailVc.homeSubTotalItem = homeSubtotal[indexPath.row] as! JENHomeSubTotalItem
        navigationController?.pushViewController(homeDetailVc, animated: true)
    }

}


