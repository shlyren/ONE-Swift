//
//  JENTableFooterView.swift
//  ONE_Swift
//
//  Created by 任玉祥 on 16/4/28.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

import UIKit

class JENTableFooterView: UIView {
    
    @IBOutlet weak var footerBth: UIButton!


    func footerView() -> JENTableFooterView {
        
        return NSBundle.mainBundle().loadNibNamed("JENTableFooterView", owner: nil, options: nil).first as! JENTableFooterView
    }
    
}
