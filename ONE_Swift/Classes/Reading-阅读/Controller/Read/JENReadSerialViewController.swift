//
//  JENReadSerialViewController.swift
//  ONE_Swift
//
//  Created by 任玉祥 on 16/5/4.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

import UIKit

class JENReadSerialViewController: JENReadTableViewController {

    override var readItems: [AnyObject] {
        get { return readList.serial }
    }
    
    override var readType: JENReadType {
        get { return .Serial }
    }
    
    override var pastListEndDate: String {
        get { return "2016-01" }
    }

}

// MARK: - tableView protocol
extension JENReadSerialViewController {
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> JENReadCell {
        let cell = super.tableView(tableView, cellForRowAtIndexPath: indexPath)
        cell.serial = readItems[indexPath.row] as! JENReadSerialItem
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let serialVc = JENSerialDetailViewController()
        guard let detail_id = (readItems[indexPath.row] as! JENReadSerialItem).content_id else { return }
        serialVc.detail_id = detail_id
        navigationController?.pushViewController(serialVc, animated: true)
    }
}