//
//  JENExtensionView.swift
//  ONE_Swift
//
//  Created by 任玉祥 on 16/4/28.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

import UIKit

class JENExtensionView : UIView {
    
    @IBOutlet private weak var footerBth: UIButton!
}

// MARK: - public methods
extension JENExtensionView {
    
    /**
     往期列表footerView
     */
    class func pastListFooterView(target: AnyObject, action: Selector) -> JENExtensionView {
        let footerView = loadPastListFooterView()
        footerView.height = 44
        footerView.footerBth.addTarget(target, action: action, forControlEvents: .TouchUpInside)
        return footerView
    }
    /**
     推荐列表sectionHeaderView
     */
    class func relatedSectionHeaderView() -> JENExtensionView {
        return loadRelatedSectionHeaderView()
    }
    
    /**
     评论列表sectionHeaderView
     */
    class func commentSectionHeaderView() -> JENExtensionView {
        return loadCommentSectionHeaderView()
    }
}


// MARK: - private methods
private extension JENExtensionView {
    
    // MARK: 评论列表sectionHeaderView
    class func loadCommentSectionHeaderView() -> JENExtensionView {
        return loadViewWithNib()[2]
    }
    
    // MARK: 推荐列表sectionHeaderView
    class func loadRelatedSectionHeaderView() -> JENExtensionView {
        return loadViewWithNib()[1]
    }

    // MARK: 往期列表footerView
    class func loadPastListFooterView() -> JENExtensionView {
        return loadViewWithNib()[0]
    }
    
    // MARK: 加载Nib
    class func loadViewWithNib() -> [JENExtensionView] {
        return NSBundle.mainBundle().loadNibNamed("JENExtensionView", owner: nil, options: nil) as! [JENExtensionView]
    }
    
}