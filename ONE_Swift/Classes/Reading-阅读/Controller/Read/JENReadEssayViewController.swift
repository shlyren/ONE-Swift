//
//  JENReadEssayViewController.swift
//  ONE_Swift
//
//  Created by 任玉祥 on 16/5/4.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

import UIKit

class JENReadEssayViewController : JENReadTableViewController {

    override var readItems: [AnyObject] {
        get { return readList.essay }
    }
    
    override var readType: JENReadType {
        get { return .Essay }
    }

}

// MARK: - tableView protocol
extension JENReadEssayViewController {
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> JENReadCell {
        let cell = super.tableView(tableView, cellForRowAtIndexPath: indexPath)
        cell.essay = readItems[indexPath.row] as! JENReadEssayItem
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let essayVc = JENEssayDetailViewController()
        guard let detail_id = (readItems[indexPath.row] as! JENReadEssayItem).content_id else {return}
        essayVc.detail_id = detail_id
        navigationController?.pushViewController(essayVc, animated: true)
    }
}