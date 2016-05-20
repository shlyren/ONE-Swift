//
//  JENMovieDetailViewController.swift
//  ONE_Swift
//
//  Created by 任玉祥 on 16/5/10.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

import UIKit

class JENMovieDetailViewController: UITableViewController {

    
    var detail_id = ""
    
    private lazy var detailView: JENMovieHeaderView = {
        let headerView = JENMovieHeaderView.headerView(self.detail_id)
        headerView.contentChange {[weak self] (height) in
            headerView.height = height
            self!.tableView.tableHeaderView = headerView
       
        }
        return headerView
    }()
    deinit {
        print("JENMovieDetailViewController == deinit")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
}

private extension JENMovieDetailViewController {
    func setupView() {
    
        tableView.tableHeaderView = detailView
    }
}


// MARK: - Table view data source
extension JENMovieDetailViewController {
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 0
    }
}

extension JENMovieDetailViewController {
    
}