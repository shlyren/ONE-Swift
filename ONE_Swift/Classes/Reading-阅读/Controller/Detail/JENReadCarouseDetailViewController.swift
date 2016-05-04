//
//  JENReadCarouseDetailViewController.swift
//  ONE_Swift
//
//  Created by 任玉祥 on 16/5/3.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

import UIKit

class JENReadCarouseDetailViewController : UIViewController {
    
    // MARK: - lazy load
        /// 头部Label
    private lazy var headerLabel : UILabel = {
        let headerLabel = UILabel()
        headerLabel.backgroundColor = UIColor.clearColor()
        headerLabel.textColor = UIColor.whiteColor()
        headerLabel.textAlignment = .Center
        headerLabel.height = 70
        self.tableView.tableHeaderView = headerLabel
        return headerLabel
    }()
        /// 尾部Label
    private lazy var footerLabel : UILabel = {
        let footerLabel = UILabel()
        footerLabel.backgroundColor = UIColor.clearColor()
        footerLabel.textColor = UIColor.whiteColor()
        footerLabel.numberOfLines = 0
        footerLabel.x = 30
        footerLabel.centerY = self.footerView.height * 0.5 - 50
        footerLabel.width = UIScreen.mainScreen().bounds.size.width - 2 * 30
        self.footerView.addSubview(footerLabel)
        return footerLabel
    }()
        ///  尾部View
    private lazy var footerView : UIView = {
        let footerView = UIView()
        footerView.height = 500
        footerView.backgroundColor = UIColor.clearColor()
        self.tableView.tableFooterView = footerView
        return footerView
    }()
    
    private let readCarouseCellId = "ReadCarouseCell"
    
        /// 轮播的模型数组
    private lazy var carouselDetailItems : [JENReadCarouselItem] = {
        let carouselDetailItems = [JENReadCarouselItem]()
        return carouselDetailItems
    }()
    
        /// 轮播列表模型
    var readCarouseListItem = JENReadCarouselListItem() {
        didSet {
            view.backgroundColor = UIColor.colorWithHexString(readCarouseListItem.bgcolor)
            headerLabel.text = readCarouseListItem.title
            footerLabel.text = readCarouseListItem.bottom_text
            headerLabel.sizeToFit()
            footerLabel.sizeToFit()
            
            guard let carousel_id = readCarouseListItem.carousel_id else {
                return
            }
            JENLoadData.loadReadCarouselDetail(carousel_id) { (responseObject) in
                if responseObject.count > 0 {
                    self.carouselDetailItems = responseObject
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        tableView.insetT = 50
        tableView.separatorInset.top = tableView.insetT
        tableView.scrollIndicatorInsets.top = 20
        tableView.registerNib(UINib.init(nibName: "JENReadCarouseCell", bundle: nil), forCellReuseIdentifier: readCarouseCellId)
        tableView.separatorStyle = .None
    }

    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    @IBAction func close() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
}

extension JENReadCarouseDetailViewController : UITableViewDataSource, UITableViewDelegate {

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.carouselDetailItems.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(readCarouseCellId) as! JENReadCarouseCell
        let carouseItem = self.carouselDetailItems[indexPath.row]
        carouseItem.number = "\(indexPath.row + 1)"
        cell.carouselItem = carouseItem
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let cell = tableView.dequeueReusableCellWithIdentifier(readCarouseCellId) as! JENReadCarouseCell
        cell.carouselItem = self.carouselDetailItems[indexPath.row]
        return cell.rowHeight
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let detailItem = carouselDetailItems[indexPath.row]
        var readDetailVc : JENReadDetailViewController?
        
        switch detailItem.readType {
            case .Essay:
                readDetailVc = JENEssayDetailViewController()
                readDetailVc?.title = "短篇"
            case .Serial:
                readDetailVc = JENSerialDetailViewController()
                readDetailVc?.title = "连载"
            case .Question:
                readDetailVc = JENQuestionDetailViewController()
                readDetailVc?.title = "问答"
            default: break
        }
        
        guard let detailVc = readDetailVc else {return}
        guard let item_id = detailItem.item_id else { return }
        detailVc.detail_id = item_id
        navigationController?.pushViewController(detailVc, animated: true)
    }

}
