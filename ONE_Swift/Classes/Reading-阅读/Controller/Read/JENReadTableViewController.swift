//
//  JENReadTableViewController.swift
//  ONE_Swift
//
//  Created by 任玉祥 on 16/5/4.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

import UIKit

class JENReadTableViewController: UITableViewController {

    var readList = JENReadListItem()
    
    var readType: JENReadType {
        get { return .Unknow }
    }
    
    var pastListEndDate: String {
        get { return "2012-10" }
    }
    
    var readItems: [AnyObject] {
        get { return [] }
    }
    
    private let readCellID = "JENReadCell"
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

// MARK: - view
extension JENReadTableViewController {
   private func setupView() {
        automaticallyAdjustsScrollViewInsets = false
        tableView.registerNib(UINib.init(nibName: readCellID, bundle: nil), forCellReuseIdentifier: readCellID)
        tableView.insetT = JENTitleViewH + JENDefaultMargin
        tableView.scrollIndicatorInsets.top = JENTitleViewH
        tableView.separatorStyle = .None
        tableView.tableFooterView = JENExtensionView.pastListFooterView(self, action: #selector(footerBtnClick))
    }
}

// MARK: - tableView protocol
extension JENReadTableViewController {
    // MARK: - Table view data source
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return readItems.count
    }

     override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> JENReadCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(readCellID, forIndexPath: indexPath) as! JENReadCell
        return cell
     }
    
    // MARK: Table view data delegate
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return readItems[indexPath.row].rowHeight
    }

}

// MARK: - Event
private extension JENReadTableViewController {
    @objc private func footerBtnClick() {
        let pastListVc = JENReadPastListViewController()
        pastListVc.endMonth = pastListEndDate
        pastListVc.readType = readType
        navigationController?.pushViewController(pastListVc, animated: true)
    }
}
