//
//  JENEssayDetailViewController.swift
//  ONE_Swift
//
//  Created by 任玉祥 on 16/5/4.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

import UIKit

class JENEssayDetailViewController: JENReadDetailViewController {
    
    override var readType: JENReadType {
        return .Essay
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "短篇"
    }
    
    override func loadRealtedData() {
        super.loadRealtedData()
        JENLoadData.loadReadEssayRelated("related/essay/" + detail_id) { (resObj) in
            if resObj.count > 0 {
                self.relatedItems = resObj
            }
        }
    }
}

extension JENEssayDetailViewController {
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        super.tableView(tableView, didSelectRowAtIndexPath: indexPath)
        
        if indexPath.section == 0 && relatedItems.count > 0 {
            let essayDetailVC = JENEssayDetailViewController()
            let essayItem = relatedItems[indexPath.row] as! JENReadEssayItem
            guard let content_id = essayItem.content_id else { return }
            essayDetailVC.detail_id = content_id
            navigationController?.pushViewController(essayDetailVC, animated: true)
        }

    }
}