//
//  JENReadToolBarView.swift
//  ONE_Swift
//
//  Created by 任玉祥 on 16/5/4.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

import UIKit

class JENReadToolBarView : UIView {

    @IBOutlet private weak var praiseBtn: UIButton!
    @IBOutlet private weak var commentBtn: UIButton!
    @IBOutlet private weak var shareBtn: UIButton!
    
    var readType = JENReadType.Unknow
    var detail_id = ""
    
    
    class func toolBarView(type: JENReadType, detail_id: String) -> JENReadToolBarView {
        
        let toolBar = NSBundle.mainBundle().loadNibNamed("JENReadToolBarView", owner: nil, options: nil).first as! JENReadToolBarView
        toolBar.frame = CGRectMake(0, JENScreenHeight - 44, JENScreenWidth, 44)
        toolBar.readType = type
        toolBar.detail_id = detail_id
        return toolBar
    }
    
    func setToolBarTitle(praisenum: Int, commentnum: Int, sharenum: Int) {
        praiseBtn.setTitle("\(praisenum)", forState: .Normal)
        praiseBtn.setTitle("\(praisenum)", forState: .Selected)
        commentBtn.setTitle("\(commentnum)", forState: .Normal)
        commentBtn.setTitle("\(commentnum)", forState: .Highlighted)
        shareBtn.setTitle("\(sharenum)", forState: .Normal)
        shareBtn.setTitle("\(sharenum)", forState: .Highlighted)
    }
}
