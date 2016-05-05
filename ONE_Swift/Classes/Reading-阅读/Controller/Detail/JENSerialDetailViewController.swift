//
//  JENSerialDetailViewController.swift
//  ONE_Swift
//
//  Created by 任玉祥 on 16/5/4.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

import UIKit

class JENSerialDetailViewController : JENReadDetailViewController {

    override var readType: JENReadType {
        return .Serial
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "连载"
    }
    
    override func loadRealtedData() {
        JENLoadData.loadReadSerialRelated(detail_id) { (responseObject) in
            if responseObject.count > 0 {
                self.relatedItems = responseObject
                super.loadRealtedData()
            }
        }
    }
}

extension JENSerialDetailViewController {
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        super.tableView(tableView, didSelectRowAtIndexPath: indexPath)
        
        if indexPath.section == 0 && relatedItems.count > 0 {
            let serialDetailVC = JENSerialDetailViewController()
            let serialItem = relatedItems[indexPath.row] as! JENReadSerialItem
            guard let content_id = serialItem.content_id else { return }
            serialDetailVC.detail_id = content_id
            navigationController?.pushViewController(serialDetailVC, animated: true)
        }
    }
}