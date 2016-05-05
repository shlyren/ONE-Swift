//
//  JENReadQuestionViewController.swift
//  ONE_Swift
//
//  Created by 任玉祥 on 16/5/4.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

import UIKit

class JENReadQuestionViewController : JENReadTableViewController {

    override func readItems() -> [AnyObject] {
        return readList.question
    }

}

// MARK: - tableView protocol
extension JENReadQuestionViewController {
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> JENReadCell {
        let cell = super.tableView(tableView, cellForRowAtIndexPath: indexPath)
        cell.question = readItems()[indexPath.row] as! JENReadQuestionItem
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let questionVc = JENQuestionDetailViewController()
        guard let question_id = (readItems()[indexPath.row] as! JENReadQuestionItem).question_id else {
            return
        }
        questionVc.detail_id = question_id
        navigationController?.pushViewController(questionVc, animated: true)
    }
}