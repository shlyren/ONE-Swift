//
//  JENReadDetailHeaderView.swift
//  ONE_Swift
//
//  Created by 任玉祥 on 16/5/4.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

import UIKit
import SDWebImage

typealias ContentChangBlock = (height: CGFloat?, num: (praisenum: Int, sharenum: Int, commentnum: Int)) ->()

class JENReadDetailHeaderView: UIView {
    
    var readType = JENReadType.Unknow {
        didSet {
            if readType == .Essay { loadEssayData() }
            if readType == .Serial { loadSerialData() }
            if readType == .Question { loadQuestionData() }
        }
    }
    
    var detail_id = ""
    
    func contentChang(contentChangBlock: ContentChangBlock) {
        self.contentChangBlock = contentChangBlock
    }
    
    deinit {
        print("readHeader == deinit")
    }
    
// MARK: - ======私有属性======
// MARK: - 短篇,连载headerView
    @IBOutlet private weak var audioBtn:                UIButton!
    @IBOutlet private weak var listBtn:                 UIButton!
    @IBOutlet private weak var iconImgView:             UIImageView!
    @IBOutlet private weak var nameLabel:               UILabel!
    @IBOutlet private weak var maketimeLabel:           UILabel!
    @IBOutlet private weak var titleLabel:              UILabel!
    @IBOutlet private weak var contentLabel:            UILabel!
    @IBOutlet private weak var chargeEdtLabel:          UILabel!
    
// MARK: - bottom
    @IBOutlet private weak var bottomIconImgView:       UIImageView!
    @IBOutlet private weak var bottomNameLabel:         UILabel!
    @IBOutlet private weak var weiboLabel:              UILabel!
    @IBOutlet private weak var descLabel:               UILabel!
    
// MARK: - 问题 headerView
    @IBOutlet private weak var questionTitleLabel:     UILabel!
    @IBOutlet private weak var questionContentLabel:   UILabel!
    @IBOutlet private weak var answerTitleLabel:       UILabel!
    @IBOutlet private weak var answerContentLabel:     UILabel!
    @IBOutlet private weak var q_charegeEdtLabel:      UILabel!
    @IBOutlet private weak var questionMaketimeLabel:  UILabel!
    
    private var contentChangBlock: ContentChangBlock?
    
// MARK: - 列表的View 属性
    /// 列表view 的高度
    private let listViewH: CGFloat = 90
    /// title的高度
    private let listTitleLabelH: CGFloat = 60
    /// 底部Scrollview的高度
    private let listScrollViewH: CGFloat = 30
    
    private var serial_id = ""
    
    // MARK: - lazy load
        /// 列表的view
    private lazy var listView: UIView = {
        let listView = UIView()
        listView.width = self.width
        listView.x = self.x
        listView.height = self.listViewH
        listView.y = self.y - listView.height
        listView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        listView.userInteractionEnabled = true;
        self.addSubview(listView)
        return listView
    }()
        /// 列表的title
    private lazy var listTitleLabel: UILabel = {
        let listTitleLabel = UILabel()
        listTitleLabel.frame = CGRectMake(30, 0, self.width - 60, self.listTitleLabelH);
        listTitleLabel.textAlignment = .Center;
        listTitleLabel.numberOfLines = 0;
        listTitleLabel.font = JENDefaultFont;
        listTitleLabel.textColor = UIColor(white: 0.6, alpha: 1)
        self.listView.addSubview(listTitleLabel)
        return listTitleLabel
    }()
        /// 列表按钮Scrollview
    private lazy var listScrollView: UIScrollView = {
        let listScrollView = UIScrollView()
        listScrollView.frame = CGRectMake(0, self.listTitleLabelH, self.width, self.listScrollViewH);
        listScrollView.showsVerticalScrollIndicator = false;
        listScrollView.showsHorizontalScrollIndicator = false;
        self.listView.addSubview(listScrollView)
        return listScrollView
    }()
        /// 列表的数组
    var serialListItem = [JENReadSerialItem]()

}

// MARK: - listView methods
private extension JENReadDetailHeaderView {
    
    // MARK: 列表按钮点击
    @IBAction private func listBtnClick() {
        listView.hidden = false
        
        if listView.y == -listViewH {
            UIView.animateWithDuration(0.4, animations: { 
                self.listView.y += self.listViewH
                self.listView.alpha = 0.95
            })
        }else {
            hiddenListView()
        }
        
        listTitleLabel.text = titleLabel.text
        
        if  serialListItem.count != 0 {return}
        JENLoadData.loadSerialList(serial_id) { (resObj) in
            if resObj.count > 0 {
                self.serialListItem = resObj
                self.setupListBtn()
            }
        }
    }
    
    // MARK: - 初始化列表里面的的按钮
    func setupListBtn() {
        let margin: CGFloat = 20
        
        for i in 0 ..< serialListItem.count {
            let listTitleBtn = UIButton(type: .Custom)
            listTitleBtn.frame = CGRectMake(margin + CGFloat(i) * (listScrollViewH + margin), 0, listScrollViewH, listScrollViewH)
            listTitleBtn.tag = i
            listTitleBtn.addTarget(self, action: #selector(listTitleBtnClick(_:)), forControlEvents: .TouchUpInside)
            listTitleBtn.setTitleColor(JENDefaultColor, forState: .Normal)
            listTitleBtn.setTitle(serialListItem[i].number, forState: .Normal)
            listTitleBtn.titleEdgeInsets.top = -7
            listScrollView.addSubview(listTitleBtn)
            listScrollView.contentW = CGFloat(serialListItem.count) * (margin + listScrollViewH)
        }
    
    }
    
    // MARK: - 列表里面的的按钮点击
    @objc func listTitleBtnClick(listTitleBtn: UIButton) {
        let item = serialListItem[listTitleBtn.tag]
        
        guard let detail_id = item.content_id else { return }
        self.detail_id = detail_id
        loadSerialData()
        hiddenListView()
    }
    
    // MARK: - 隐藏列表的view
    func hiddenListView() {
        UIView.animateWithDuration(0.4) { 
            self.listView.y -= self.listViewH
            self.listView.alpha = 0.0
        }
    }
}

// MARK: - load Data
private extension JENReadDetailHeaderView {
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
                self.iconImgView.sd_setImageWithURL(NSURL(string: web_url), placeholderImage: JENAuthorPlaceholderImage, completed: { (image: UIImage?, _, _, _) in
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
            
            if let contentChangBlock = self.contentChangBlock {
                self.layoutIfNeeded()
                let height = 110 + self.contentLabel.height + self.titleLabel.height + 30 + 90;
                contentChangBlock(height: height, num: (essay.praisenum, essay.sharenum, essay.commentnum))
            }
         }
    }
    // MARK: 连载
    func loadSerialData() {
        
        JENLoadData.loadReadSerialDetail(detail_id) { (serial) in
            if let serial_id = serial.serial_id {
                self.serial_id = serial_id
            }
            
            self.listBtn.hidden              = false;
            self.nameLabel.text              = serial.author.user_name;
            self.maketimeLabel.text          = serial.maketime;
            self.titleLabel.text             = serial.title;
            self.contentLabel.attributedText = NSMutableAttributedString.attributedStringWithString(serial.content)
            self.chargeEdtLabel.text         = serial.charge_edt;
            
            if let webUrl = serial.author.web_url {
                self.iconImgView.sd_setImageWithURL(NSURL(string: webUrl), placeholderImage: JENAuthorPlaceholderImage, completed: { (image: UIImage!, _, _, _) in
                    self.iconImgView.image       = image.circleImage()
                    self.bottomIconImgView.image = image.circleImage()
                })
            }
            
            self.bottomNameLabel.text        = self.nameLabel.text;
            self.weiboLabel.text             = serial.author.wb_name
            self.descLabel.text              = serial.author.desc;
            
            self.contentLabel.sizeToFit()
            self.titleLabel.sizeToFit()
           
            if let contentChangBlock = self.contentChangBlock {
                self.layoutIfNeeded()
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
            
            self.q_charegeEdtLabel.text = questionItem.charge_edt;
            
            if let contentChangBlock = self.contentChangBlock {
                self.layoutIfNeeded()
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
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if listView.y == 0 {
            hiddenListView()
        }
    }
}
