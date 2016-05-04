//
//  JENReadDetailHeaderView.swift
//  ONE_Swift
//
//  Created by 任玉祥 on 16/5/4.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

import UIKit
import SDWebImage

typealias ContentChangBlock = (height : CGFloat?, num : (praisenum : Int, sharenum : Int, commentnum : Int)) ->()

class JENReadDetailHeaderView: UIView {
    
    
//    private lazy var toolBar : JENReadToolBarView = {
//        let toolBar = JENReadToolBarView.toolBarView(readType, detail_id: detail_id)
//
//        return toolBar
//    }()

    var readType = JENReadType.Unknow {
        didSet {
            if readType == .Essay { loadEssayData() }
            if readType == .Serial { loadSerialData() }
            if readType == .Question { loadQuestionData() }
        }
    }
    
    var detail_id = ""
    
    deinit {
        print("readHeader == deinit")
    }
    
    private var contentChangBlock: ContentChangBlock?

    func contentChang(contentChangBlock: ContentChangBlock) {
        self.contentChangBlock = contentChangBlock
    }
    
// MARK: - 私有属性
// MARK: 短篇,连载headerView
    @IBOutlet private weak var audioBtn:                UIButton!
    @IBOutlet private weak var listBtn:                 UIButton!
    @IBOutlet private weak var iconImgView:             UIImageView!
    @IBOutlet private weak var nameLabel:               UILabel!
    @IBOutlet private weak var maketimeLabel:           UILabel!
    @IBOutlet private weak var titleLabel:              UILabel!
    @IBOutlet private weak var contentLabel:            UILabel!
    @IBOutlet private weak var chargeEdtLabel:          UILabel!
    
// MARK: bottom
    @IBOutlet private weak var bottomIconImgView:       UIImageView!
    @IBOutlet private weak var bottomNameLabel:         UILabel!
    @IBOutlet private weak var weiboLabel:              UILabel!
    @IBOutlet private weak var descLabel:               UILabel!
    
// MARK: 问题 headerView
    @IBOutlet private weak var questionTitleLabel :     UILabel!
    @IBOutlet private weak var questionContentLabel :   UILabel!
    @IBOutlet private weak var answerTitleLabel :       UILabel!
    @IBOutlet private weak var answerContentLabel :     UILabel!
    @IBOutlet private weak var q_charegeEdtLabel :      UILabel!
    @IBOutlet private weak var questionMaketimeLabel :  UILabel!
    

}

// MARK: - load Data
extension JENReadDetailHeaderView {
    // MARK: 短篇
    func loadEssayData() {
        
        JENLoadData.loadReadEssayDetail(detail_id) { (essay) in
            self.audioBtn.hidden             = essay.has_audio
            self.nameLabel.text              = essay.hp_author
            self.maketimeLabel.text          = essay.hp_makettime
            self.titleLabel.text             = essay.hp_title
            self.contentLabel.attributedText = NSMutableAttributedString.attributedStringWithString(essay.hp_content)
            self.chargeEdtLabel.text         = essay.hp_author_introduce
            
            if let web_url = essay.author.first?.web_url {
                self.iconImgView.sd_setImageWithURL(NSURL(string: web_url), placeholderImage: JENAuthorPlaceholderImage, completed: { (image : UIImage?, _, _, _) in
                    guard let image = image else {return}
                    self.iconImgView.image       = image.circleImage()
                    self.bottomIconImgView.image = image.circleImage()
                })
            }
            
            self.bottomNameLabel.text        = essay.hp_author
            self.descLabel.text              = essay.author.first?.desc
            self.weiboLabel.text             = essay.author.first?.wb_name

            self.contentLabel.sizeToFit()
            self.titleLabel.sizeToFit()
            self.layoutIfNeeded()
            
            if let contentChangBlock = self.contentChangBlock {
                let height = 110 + self.contentLabel.height + self.titleLabel.height + 30 + 90;
                contentChangBlock(height: height, num: (essay.praisenum, essay.sharenum, essay.commentnum))
            }
         }
    }
    // MARK: 连载
    func loadSerialData() {
        
        JENLoadData.loadReadSerialDetail(detail_id) { (serial) in

            self.listBtn.hidden              = false;
            self.nameLabel.text              = serial.author.user_name;
            self.maketimeLabel.text          = serial.maketime;
            self.titleLabel.text             = serial.title;
            self.contentLabel.attributedText = NSMutableAttributedString.attributedStringWithString(serial.content)
            self.chargeEdtLabel.text         = serial.charge_edt;
            
            if let webUrl = serial.author.web_url {
                self.iconImgView.sd_setImageWithURL(NSURL(string: webUrl), placeholderImage: JENAuthorPlaceholderImage, completed: { (image : UIImage!, _, _, _) in
                    self.iconImgView.image       = image.circleImage()
                    self.bottomIconImgView.image = image.circleImage()
                })
            }
            
           
            
            self.bottomNameLabel.text        = self.nameLabel.text;
            self.weiboLabel.text             = serial.author.wb_name
            self.descLabel.text              = serial.author.desc;
            
            self.contentLabel.sizeToFit()
            self.titleLabel.sizeToFit()
            self.layoutIfNeeded()

            if let contentChangBlock = self.contentChangBlock {
                let height = 110 + self.contentLabel.height + self.titleLabel.height + 30 + 90;
                contentChangBlock(height: height, num: (serial.praisenum, serial.sharenum, serial.commentnum))
            }
            
        }
    }
    // MARK: 问答
    func loadQuestionData() {
        
        JENLoadData.loadReadQuestionDetail(detail_id) { (questionItem) in
            self.questionTitleLabel.text = questionItem.question_title;
            self.questionContentLabel.attributedText = NSMutableAttributedString.attributedStringWithString(questionItem.question_content)
            self.questionContentLabel.sizeToFit()
            self.questionMaketimeLabel.text = questionItem.last_update_date;
            self.answerTitleLabel.text = questionItem.answer_title;
            self.answerContentLabel.text = questionItem.answer_content;
            self.answerContentLabel.attributedText = NSMutableAttributedString.attributedStringWithString(questionItem.answer_content)
            self.answerContentLabel.sizeToFit()
            self.layoutIfNeeded()
            
            self.q_charegeEdtLabel.text = questionItem.charge_edt;
            
            if let contentChangBlock = self.contentChangBlock {
                let height = CGRectGetMaxY(self.questionContentLabel.frame) + self.questionContentLabel.height + 50 + self.answerTitleLabel.height + 20 + self.answerContentLabel.height + self.q_charegeEdtLabel.height + 20;
                contentChangBlock(height: height, num: (questionItem.praisenum, questionItem.sharenum, questionItem.commentnum))
            }
        }
    }
}

// MARK: - load Nib
extension JENReadDetailHeaderView {

    class func detailHeaderView() -> JENReadDetailHeaderView {
        return NSBundle.mainBundle().loadNibNamed("JENReadDetailHeaderView", owner: nil, options: nil).first as! JENReadDetailHeaderView
    }
    
    class func questionDetailHeaderView() -> JENReadDetailHeaderView {
        return NSBundle.mainBundle().loadNibNamed("JENReadDetailHeaderView", owner: nil, options: nil).last as! JENReadDetailHeaderView
    }
}
