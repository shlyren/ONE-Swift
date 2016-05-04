//
//  JENTableFooterView.swift
//  ONE_Swift
//
//  Created by 任玉祥 on 16/4/28.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

import UIKit

class JENTableFooterView: UIView {
    
    @IBOutlet private weak var footerBth: UIButton!
    
    class func footerView(target : AnyObject, action : Selector) -> JENTableFooterView {
        
        let footerView = NSBundle.mainBundle().loadNibNamed("JENTableFooterView", owner: nil, options: nil).first as! JENTableFooterView
        footerView.height = 44
        footerView.footerBth.addTarget(target, action: action, forControlEvents: .TouchUpInside)
        return footerView
    }
    
}
