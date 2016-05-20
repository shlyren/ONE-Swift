//
//  JENTitleButton.swift
//  ONE_Swift
//
//  Created by 任玉祥 on 16/5/4.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

import UIKit

class JENTitleButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        titleLabel?.font = JENDefaultFont
        setTitleColor(JENDefaultColor, forState: .Selected)
        setTitleColor(UIColor.darkGrayColor(), forState: .Normal)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var highlighted: Bool {
        set {}
        get { return super.highlighted }
    }

}
