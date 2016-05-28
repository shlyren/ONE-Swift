//
//  JENReadPastListResultVC.swift
//  ONE_Swift
//
//  Created by 任玉祥 on 16/5/6.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

import UIKit

class JENReadPastListResultVC: UITableViewController {

    
    var month: String?
    var readType = JENReadType.Unknow
    
    private var relatedData = [AnyObject]() {
        didSet { tableView.reloadData() }
    }
    
    private let relatedCellID = "JENReadRelatedCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.registerNib(UINib.init(nibName: "JENReadRelatedCell", bundle: nil), forCellReuseIdentifier: relatedCellID)
        
        title = month
        loadData()
    }

  
}

// MARK: - private methods
private extension JENReadPastListResultVC {
    func loadData() {
        
        guard let month = month else { return }
        let urlStr = "bymonth/" + month
        switch readType {
            case .Essay:
            JENLoadData.loadReadEssayRelated("essay/" + urlStr, completion: { (resObj) in
                self.relatedData = resObj
            })
            case .Serial:
            JENLoadData.loadReadSerialRelated("serialcontent/" + urlStr, completion: { (resObj) in
                self.relatedData = resObj
            })
            case .Question:
            JENLoadData.loadReadQuestionRelated("question/" + urlStr, completion: { (resObj) in
                self.relatedData = resObj
            })
            default:break
        }
    }
}


// MARK: - table view protocol
extension JENReadPastListResultVC {
    
    // MARK: Table view data source
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.tableViewWithNoData(nil, rowCount: relatedData.count)
        return relatedData.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        tableView.tableViewSetExtraCellLineHidden()
        let cell = tableView.dequeueReusableCellWithIdentifier(relatedCellID) as! JENReadRelatedCell
        cell.readType = readType
        cell.relatedItem = relatedData[indexPath.row] as! NSObject
        
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let relatedCell = tableView.dequeueReusableCellWithIdentifier(relatedCellID) as! JENReadRelatedCell
        relatedCell.readType = readType
        relatedCell.relatedItem = relatedData[indexPath.row] as! NSObject
        return relatedCell.rowHeight
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        switch readType {
            
            case .Essay:
                let essayItem = relatedData[indexPath.row] as! JENReadEssayItem
                guard let detail_id = essayItem.content_id else { break }
                let relatedVc = JENEssayDetailViewController()
                relatedVc.detail_id = detail_id
                navigationController?.pushViewController(relatedVc, animated: true)
            
            case .Serial:
                let serialItem = relatedData[indexPath.row] as! JENReadSerialItem
                guard let detail_id = serialItem.content_id else { break }
                let relatedVc = JENSerialDetailViewController()
                relatedVc.detail_id = detail_id
                navigationController?.pushViewController(relatedVc, animated: true)
            
            case .Question:
                let questionItem = relatedData[indexPath.row] as! JENReadQuestionItem
                guard let detail_id = questionItem.question_id else { break }
                let relatedVc = JENQuestionDetailViewController()
                relatedVc.detail_id = detail_id
                navigationController?.pushViewController(relatedVc, animated: true)
        
        default:break
            
        }
        
    }

}
