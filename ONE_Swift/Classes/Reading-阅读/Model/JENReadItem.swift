//
//  JENReadItem.swift
//  ONE_Swift
//
//  Created by 任玉祥 on 16/5/4.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

import UIKit

// MARK: - 阅读的类型
enum JENReadType: String {
    /// 未知
    case Unknow = ""
    /// 短篇
    case Essay = "essay"
    /// 连载
    case Serial = "serial"
    /// 问答
    case Question = "question"
}

// MARK: - 阅读列表模型
class JENReadListItem: NSObject {

    var essay = [JENReadEssayItem]()
    var serial = [JENReadSerialItem]()
    var question = [JENReadQuestionItem]()
}

// MARK: - 短篇模型
class JENReadEssayItem: NSObject {
    /// 内容id
    var content_id: String?
    /// 标题
    var hp_title: String?
    /// 创作时间
    var hp_makettime: String?
    /// 简介
    var guide_word: String?
    /// 作者
    var author = [JENAuthorItem]()
    /// 是否有音频
    var has_audio = false
    
    /// 行高
    private var height: CGFloat = 0.0
    var rowHeight: CGFloat {
        
        if height > JENDefaultMargin { return height }
        
        height += JENDefaultMargin
        height += (hp_title! as NSString).boundingRectWithSize(CGSizeMake(JENScreenWidth - 4 * JENDefaultMargin, CGFloat(MAXFLOAT)), options: .UsesLineFragmentOrigin, attributes: [NSFontAttributeName: UIFont.boldSystemFontOfSize(17)], context: nil).size.height + 5
        height += 25
        height += (guide_word! as NSString).boundingRectWithSize(CGSizeMake(JENScreenWidth - 4 * JENDefaultMargin, CGFloat(MAXFLOAT)), options: .UsesLineFragmentOrigin, attributes: [NSFontAttributeName: JENDefaultFont], context: nil).size.height + JENDefaultMargin
        height += JENDefaultMargin
        
        return height
    }
    
}

// MARK: - 连载模型
class JENReadSerialItem: NSObject {
    /// 内容id   服务器 -> id
    var content_id: String?
    /// 连载id
    var serial_id: String?
    /// 序列号
    var number: String?
    /// 标题
    var title: String?
    /// 简介
    var excerpt: String?
    /// 阅读数
    var read_num: String?
    /// 创作时间
    var maketime: String?
    /// 作者
    var author = JENAuthorItem()
    /// 是否有音频
    var has_audio = false
    
    /// 行高
    private var height: CGFloat = 0.0
    var rowHeight: CGFloat {
        
        if height > JENDefaultMargin { return height }
        
        height += JENDefaultMargin
        height += (title! as NSString).boundingRectWithSize(CGSizeMake(JENScreenWidth - 4 * JENDefaultMargin, CGFloat(MAXFLOAT)), options: .UsesLineFragmentOrigin, attributes: [NSFontAttributeName: UIFont.boldSystemFontOfSize(17)], context: nil).size.height + 5
        height += 25
        height += (excerpt! as NSString).boundingRectWithSize(CGSizeMake(JENScreenWidth - 4 * JENDefaultMargin, CGFloat(MAXFLOAT)), options: .UsesLineFragmentOrigin, attributes: [NSFontAttributeName: JENDefaultFont], context: nil).size.height + JENDefaultMargin
        height += JENDefaultMargin
        
        return height

    }
}

// MARK: - 问答模型
class JENReadQuestionItem: NSObject {
     /// 问题id
    var question_id: String?
    /// 问题标题
    var question_title: String?
    /// 回答标题
    var answer_title: String?
    /// 回答内容
    var answer_content: String?
    /// 问题提出时间
    var question_makettime: String?
    
    /// 行高
    private var height: CGFloat = 0.0
    var rowHeight: CGFloat {
        if height > JENDefaultMargin { return height }
        
        height += JENDefaultMargin
        height += (question_title! as NSString).boundingRectWithSize(CGSizeMake(JENScreenWidth - 4 * JENDefaultMargin, CGFloat(MAXFLOAT)), options: .UsesLineFragmentOrigin, attributes: [NSFontAttributeName: UIFont.boldSystemFontOfSize(17)], context: nil).size.height + 5
        height += 25
        height += (answer_content! as NSString).boundingRectWithSize(CGSizeMake(JENScreenWidth - 4 * JENDefaultMargin, CGFloat(MAXFLOAT)), options: .UsesLineFragmentOrigin, attributes: [NSFontAttributeName: JENDefaultFont], context: nil).size.height + JENDefaultMargin
        height += JENDefaultMargin
        
        return height
    }
}