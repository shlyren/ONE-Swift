//
//  JENReadPastListViewController.swift
//  ONE_Swift
//
//  Created by 任玉祥 on 16/5/4.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

import UIKit

// MARK: - tableView protocol
class JENReadPastListViewController: JENPastListViewController {
    
    
    var readType = JENReadType.Unknow
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        super.tableView(tableView, didSelectRowAtIndexPath: indexPath)
        
        let pastListResultVc = JENReadPastListResultVC()
        pastListResultVc.month = pastLists[indexPath.row]
        pastListResultVc.readType = readType
        
        navigationController?.pushViewController(pastListResultVc, animated: true)
        
    }

}
