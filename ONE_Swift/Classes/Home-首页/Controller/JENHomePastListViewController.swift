//
//  JENHomePastListViewController.swift
//  ONE_Swift
//
//  Created by 任玉祥 on 16/4/28.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

import UIKit

class JENHomePastListViewController: JENPastListViewController {

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        super.tableView(tableView, didSelectRowAtIndexPath: indexPath)
        
        let moreSubTotalVc = JENHomeViewController()
        moreSubTotalVc.urlString = "bymonth/" + pastLists[indexPath.row]
        moreSubTotalVc.title = pastLists[indexPath.row]
        navigationController?.pushViewController(moreSubTotalVc, animated: true)
    }

}
