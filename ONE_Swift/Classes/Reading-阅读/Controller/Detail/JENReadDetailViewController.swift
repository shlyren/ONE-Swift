//
//  JENReadDetailViewController.swift
//  ONE_Swift
//
//  Created by 任玉祥 on 16/5/4.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

import UIKit

class JENReadDetailViewController: UIViewController {

    private var headerView : JENReadDetailHeaderView?
    private let tableView = UITableView()
    var detail_id = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func readHeaderView() -> JENReadDetailHeaderView {
        return JENReadDetailHeaderView.detailHeaderView()
    }
    func readType() -> JENReadType {
        return .Unknow
    }
    
    deinit {
        print("\(self.classForCoder) == deinit")
    }
}

// MARK: - view
private extension JENReadDetailViewController {
    func setupView() {
        view.backgroundColor = UIColor.whiteColor()
        tableView.frame = self.view.bounds
        tableView.insetB = 44
        tableView.delegate = self
        tableView.dataSource = self
        tableView.scrollIndicatorInsets.bottom = 44
        view.addSubview(tableView)
        
        let toolBar = JENReadToolBarView.toolBarView(readType(), detail_id: detail_id)
        view.addSubview(toolBar)
        
        headerView = self.readHeaderView()
        tableView.tableHeaderView = headerView
        headerView!.detail_id = detail_id
        headerView!.readType = readType()
        headerView!.contentChang {[weak self] (height, num) in
            self!.headerView!.height = height!
            self!.tableView.tableHeaderView = self!.headerView
            toolBar.setToolBarTitle(num.praisenum, commentnum: num.sharenum, sharenum: num.commentnum)
        }
    }
}


// MARK: - table view protocol
extension JENReadDetailViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        tableView.tableViewSetExtraCellLineHidden()
        var cell = tableView.dequeueReusableCellWithIdentifier("cell")
        if cell == nil {
            cell = UITableViewCell(style: .Default, reuseIdentifier: "cell")
        }
        cell?.textLabel?.text = "\(self.classForCoder)==\(indexPath.row)"
        return cell!
    }
}








