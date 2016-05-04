//
//  JENReadTableViewController.swift
//  ONE_Swift
//
//  Created by 任玉祥 on 16/5/4.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

import UIKit

class JENReadTableViewController: UITableViewController {

    private let readCellID = "JENReadCell"
    
    var readList = JENReadListItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func readItems() -> [AnyObject] {
        return []
    }
    func pastListEndDate() -> String {
        return "2012-10"
    }
}

extension JENReadTableViewController {
   private func setupView() {
        automaticallyAdjustsScrollViewInsets = false
        tableView.registerNib(UINib.init(nibName: "JENReadCell", bundle: nil), forCellReuseIdentifier: readCellID)
        tableView.insetT = JENTitleViewH + JENDefaultMargin
        tableView.scrollIndicatorInsets.top = JENTitleViewH
        tableView.separatorStyle = .None
        tableView.tableFooterView = JENTableFooterView.footerView(self, action: #selector(JENReadTableViewController.footerBtnClick))
    }
}

// MARK: - table view protocol
extension JENReadTableViewController {
    // MARK: - Table view data source
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return readItems().count
    }

     override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> JENReadCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(readCellID, forIndexPath: indexPath) as! JENReadCell
        return cell
     }
    
    // MARK: - Table view data delegate
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return readItems()[indexPath.row].rowHeight
    }

}

private extension JENReadTableViewController {
    @objc private func footerBtnClick() {
        let homePastListVc = JENReadPastListViewController()
        homePastListVc.endMonth = pastListEndDate()
        navigationController?.pushViewController(homePastListVc, animated: true)
    }
}
