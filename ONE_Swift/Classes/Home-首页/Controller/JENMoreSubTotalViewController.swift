//
//  JENMoreSubTotalViewController.swift
//  ONE_Swift
//
//  Created by 任玉祥 on 16/4/28.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

import UIKit

class JENMoreSubTotalViewController: UIViewController {

    var month = ""
    private var homeSubTotal = NSArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = month

        loadData()
    }

    private func loadData() {
       
        JENLoadData.shareInstance.loadHomeSubtotal("bymonth/" + month) { (responseObject) -> () in
            
            if responseObject.count > 0 {
                self.homeSubTotal = responseObject
            }
        }
    }

}
