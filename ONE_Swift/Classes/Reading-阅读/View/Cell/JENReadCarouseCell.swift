//
//  JENReadCarouseCell.swift
//  ONE_Swift
//
//  Created by 任玉祥 on 16/5/3.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

import UIKit

class JENReadCarouseCell : UITableViewCell {
    /// 标题
    @IBOutlet private weak var titleLabel: UILabel!
    /// 作者
    @IBOutlet private weak var authorLabel: UILabel!
    /// 内容
    @IBOutlet private weak var introductionLabel: UILabel!
    
    var rowHeight: CGFloat {
        layoutIfNeeded()
        let  height = titleLabel.height + 5 + authorLabel.height + JENDefaultMargin + introductionLabel.height + 30
        return height
    }
    
    var carouselItem = JENReadCarouselItem() {
        didSet {
            titleLabel.text = "\(carouselItem.number)  \(carouselItem.title!)"
            authorLabel.text = carouselItem.author
            introductionLabel.attributedText = NSMutableAttributedString.attributedStringWithString(carouselItem.introduction)
            titleLabel.sizeToFit()
            introductionLabel.sizeToFit()
        }
    }
    
    override var frame: CGRect {
        set {
            var frame = newValue
            frame.origin.x += 30
            frame.size.width -= 60
            super.frame = frame
        }
        get { return super.frame }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = UIColor.clearColor()
        self.selectionStyle = .None
        introductionLabel.preferredMaxLayoutWidth = JENScreenWidth - 80.0
        titleLabel.preferredMaxLayoutWidth = JENScreenWidth - 60.0
    }
    
    
}
