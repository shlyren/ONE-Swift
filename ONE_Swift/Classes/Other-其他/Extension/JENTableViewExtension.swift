//
//  JENTableViewExtension.swift
//  ONE_Swift
//
//  Created by 任玉祥 on 16/4/28.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

import UIKit

extension UITableView {
    
    /**
     隐藏tableview多余的分割线
     */
    func tableViewSetExtraCellLineHidden() {
        let view = UIView()
        view.backgroundColor = UIColor.whiteColor()

        tableFooterView = view
    }
    
    /**
     没有数据是显示的数据
     */
    func tableView(message : String?, rowCount : Int) {
        
        if rowCount == 0{
            
            let label = UILabel()
            label.text = message
            label.textAlignment = .Center
            label.textColor = UIColor.blackColor()
            label.sizeToFit()
            backgroundView = label
            
            separatorStyle = .None
        }else {
            backgroundView = nil
            separatorStyle = .SingleLine
        }
        
    }
    
}