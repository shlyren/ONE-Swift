//
//  JENHomeViewController.swift
//  ONE_Swift
//
//  Created by 任玉祥 on 16/4/27.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

import UIKit

class JENHomeViewController : UITableViewController {

    var urlString = "more/0"
    private let homeTableCell = "JENHomeTableCell"
    private var homeSubtotal = [JENHomeSubTotalItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupView()
        
        loadData()
    }
    
    // MARK:- 初始化view
    private func setupView() {
        tableView.registerNib(UINib(nibName: "JENHomeTableCell", bundle: nil), forCellReuseIdentifier: homeTableCell)
        tableView.insetT = JENDefaultMargin
        tableView.rowHeight = 105.0
        tableView.separatorStyle = .None
    }
    
    // MARK:- 加载数据
    private func loadData() {
        JENLoadData.loadHomeSubtotal(urlString) { (responseObject: [JENHomeSubTotalItem]) -> () in
            
            if responseObject.count > 0 {
                self.homeSubtotal = responseObject
                self.tableView.reloadData()
            }
            if self.navigationController?.childViewControllers.count == 1 {
                let footerView = JENExtensionView.pastListFooterView(self, action: #selector(JENHomeViewController.footerBtnClick))
                self.tableView.tableFooterView = footerView
            } else {
                let footerView = UIView()
                footerView.height = 10
                self.tableView.tableFooterView = footerView
            }
        }
    }
    
    // MARK:-  按钮点击事件
    @objc private func footerBtnClick() {
        let homePastListVc = JENHomePastListViewController()
        homePastListVc.endMonth = "2012-10"
        navigationController?.pushViewController(homePastListVc, animated: true)
    }
    
}

// MARK: - tableview protocol
extension JENHomeViewController {
    // MARK: tableview data source
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.homeSubtotal.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(homeTableCell) as! JENHomeTableCell
        cell.homeSubTotal = homeSubtotal[indexPath.row] 
        return cell
    }
    
    
    // MARK: table view delegate
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let homeDetailVc = JENHomeDetailViewController()
        homeDetailVc.homeSubTotalItem = homeSubtotal[indexPath.row] 
        navigationController?.pushViewController(homeDetailVc, animated: true)
    }
    

}

