//
//  JENReadRelatedCell.swift
//  ONE_Swift
//
//  Created by 任玉祥 on 16/5/5.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

import UIKit

class JENReadRelatedCell: UITableViewCell {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var contentLabel: UILabel!
    @IBOutlet private weak var typeImgView: UIImageView!

    
    var readType = JENReadType.Unknow
    var relatedItem = NSObject() {
        didSet {
            if readType == JENReadType.Unknow {
                print("readType 要在赋值模型前赋值")
            }else {
                switch readType {
                case .Essay:
                    essayItem = relatedItem as! JENReadEssayItem
                case .Serial:
                    serialItem = relatedItem as! JENReadSerialItem
                case .Question:
                    questionItem = relatedItem as! JENReadQuestionItem
                    
                default:break
                }
            }
        
        }
    }
    
    private var essayItem = JENReadEssayItem() {
        didSet {
            titleLabel.text = essayItem.hp_title
            nameLabel.text = essayItem.author.first!.user_name
            contentLabel.attributedText = NSMutableAttributedString.attributedStringWithString(essayItem.guide_word)
            typeImgView.image = UIImage(named: "essay")
        }
    }
    
    private var serialItem = JENReadSerialItem() {
        didSet {
            titleLabel.text = serialItem.title
            nameLabel.text = serialItem.author.user_name
            contentLabel.attributedText = NSMutableAttributedString.attributedStringWithString(serialItem.excerpt)
            typeImgView.image = UIImage(named: "serialcontent")
        }
    }
    
    var questionItem = JENReadQuestionItem() {
        didSet {
            titleLabel.text = questionItem.question_title
            nameLabel.text = questionItem.answer_title
            contentLabel.attributedText = NSMutableAttributedString.attributedStringWithString(questionItem.answer_content)
            typeImgView.image = UIImage(named: "question")
        }
    }
    
    var rowHeight: CGFloat {
        layoutIfNeeded()
        return CGRectGetMaxY(nameLabel.frame) + JENDefaultMargin + contentLabel.height + 15;
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentLabel.preferredMaxLayoutWidth = JENScreenWidth - 2 * JENDefaultMargin;
        titleLabel.preferredMaxLayoutWidth = JENScreenWidth - 61;

    }

    
}
