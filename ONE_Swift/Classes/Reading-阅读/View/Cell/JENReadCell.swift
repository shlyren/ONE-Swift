//
//  JENReadCell.swift
//  ONE_Swift
//
//  Created by 任玉祥 on 16/5/4.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

import UIKit

class JENReadCell : UITableViewCell {
    // MARK: - 私有属性
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var maketimeLabel: UILabel!
    @IBOutlet private weak var contentLabel: UILabel!

    // MARK: - 短篇
    var essay = JENReadEssayItem() {
        didSet {
            titleLabel.text = essay.hp_title
            nameLabel.text = essay.author.first?.user_name
            maketimeLabel.text = essay.hp_makettime
            contentLabel.text = essay.guide_word
        }
    }
    
    // MARK: - 连载
    var serial = JENReadSerialItem() {
        didSet {
            titleLabel.text = serial.title
            nameLabel.text = serial.author.user_name
            maketimeLabel.text = serial.maketime
            contentLabel.text = serial.excerpt
        }
    }
    
    // MARK: - 问答
    var question = JENReadQuestionItem() {
        didSet {
            titleLabel.text = question.question_title
            nameLabel.text = question.answer_title
            maketimeLabel.text = question.question_makettime
            contentLabel.text = question.answer_content
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundView = UIImageView(image: UIImage(named: "mainCellBackground"))
        backgroundColor = UIColor.clearColor()
        selectionStyle = .None
    }

    override var frame: CGRect {
        set {
            var frame = newValue
            frame.origin.x += JENDefaultMargin
            frame.size.width -= 2 * JENDefaultMargin
            frame.size.height -= JENDefaultMargin
            super.frame = frame
        }
        get { return super.frame }
    }
    
}
