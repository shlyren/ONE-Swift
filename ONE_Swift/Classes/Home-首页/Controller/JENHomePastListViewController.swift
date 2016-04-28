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
        let moreSubTotalVc = JENHomeViewController()
        moreSubTotalVc.urlString = "bymonth/" + pastLists[indexPath.row]
        moreSubTotalVc.title = "往期列表"
        navigationController?.pushViewController(moreSubTotalVc, animated: true)
    }

}
