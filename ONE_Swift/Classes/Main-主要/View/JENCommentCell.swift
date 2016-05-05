//
//  JENCommentCell.swift
//  ONE_Swift
//
//  Created by 任玉祥 on 16/5/5.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

import UIKit
import SDWebImage

class JENCommentCell: UITableViewCell {
    
    @IBOutlet private weak var commentContectLabel: UILabel!
    @IBOutlet private weak var praisenumBtn: UIButton!
    @IBOutlet private weak var inputDateLabel: UILabel!
    @IBOutlet private weak var userNameLabel: UILabel!
    @IBOutlet private weak var iconImageView: UIImageView!
    
    
    var rowHeight: CGFloat {
        layoutIfNeeded()
        return CGRectGetMaxY(self.commentContectLabel.frame) + 15;
    }
    
    var commentItem = JENCommentItem() {
        didSet{
            inputDateLabel.text = commentItem.input_date
            commentContectLabel.attributedText = NSMutableAttributedString.attributedStringWithString(commentItem.content)
            commentContectLabel.sizeToFit()
            praisenumBtn.setTitle("\(commentItem.praisenum)", forState: .Normal)
            
            userNameLabel.text = commentItem.user.user_name
            
            guard let user_icon = commentItem.user.web_url else { return }
            iconImageView.sd_setImageWithURL(NSURL(string: user_icon), placeholderImage: JENAuthorPlaceholderImage) { (image: UIImage!, _, _, _) in
                self.iconImageView.image = image.circleImage()
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        commentContectLabel.preferredMaxLayoutWidth = JENScreenWidth - 80
    }

    
}
