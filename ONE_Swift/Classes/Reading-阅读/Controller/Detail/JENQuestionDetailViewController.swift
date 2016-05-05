//
//  JENQuestionDetailViewController.swift
//  ONE_Swift
//
//  Created by 任玉祥 on 16/5/4.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

import UIKit

class JENQuestionDetailViewController : JENReadDetailViewController {

    
    override var readType: JENReadType {
        return .Question
    }
    
    override func readHeaderView() -> JENReadDetailHeaderView {
        return JENReadDetailHeaderView.questionDetailHeaderView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "问答"
    }

    override func loadRealtedData() {
        JENLoadData.loadReadQuestionRelated(detail_id) { (responseObject) in
            self.relatedItems = responseObject
            super.loadRealtedData()
        }
    }
}

extension JENQuestionDetailViewController {
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        super.tableView(tableView, didSelectRowAtIndexPath: indexPath)
        
        if indexPath.section == 0 && relatedItems.count > 0 {
            let questionDetailVC = JENQuestionDetailViewController()
            let questionItem = relatedItems[indexPath.row] as! JENReadQuestionItem
            guard let content_id = questionItem.question_id else { return }
            questionDetailVC.detail_id = content_id
            navigationController?.pushViewController(questionDetailVC, animated: true)
        }
    }
}