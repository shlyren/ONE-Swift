//
//  JENReadDetailItem.swift
//  ONE_Swift
//
//  Created by 任玉祥 on 16/5/4.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

import UIKit

// MARK: - 短篇详情模型
class JENReadEssayDetailItem: JENReadEssayItem {
    /// 子标题
    var sub_title: String?
    /// 作者
    var hp_author: String?
    /// 作者介绍
    var auth_it: String?
    /// 编辑人
    var hp_author_introduce: String?
    /// 内容
    var hp_content: String?
    /// 最后更新时间
    var last_update_date: String?
    /// web版
    var web_url: String?
    /// 音频
    var audio: String?

    /// 喜欢数
    var praisenum = 0
    /// 分享数
    var sharenum = 0
    /// 评论数
    var commentnum = 0
    
//        var push_id: String?
//        var wb_name: String?
//        var wb_img_url: String?
}

// MARK: - 连载详情模型
class JENReadSerialDetailItem: JENReadSerialItem {
    
    /// 内容
    var content: String?
    /// 责任编辑
    var charge_edt: String?
    /// 最后更新时间
    var last_update_date: String?
    /// 音频
    var audio: String?
    /// web版
    var web_url: String?
    /// 发布者
    var input_name: String?
    /// 最后更新人
    var last_update_name: String?
    /// 喜欢数
    var praisenum = 0
    /// 分享数
    var sharenum = 0
    /// 评论数
    var commentnum = 0
    
//    var push_id: String?
}

// MARK: - 问答详情模型
class JENReadQuestionDetailItem: JENReadQuestionItem {
     /// 问题内容
    var question_content: String?
     /// 编辑人
    var charge_edt: String?
     /// 最后更新时间
    var last_update_date: String?
     /// web版
    var web_url: String?
     /// 阅读数
    var read_num: String?
    /// 喜欢数
    var praisenum = 0
    /// 分享数
    var sharenum = 0
    /// 评论数
    var commentnum = 0
    
//    var recommend_flag: String?
//    var push_id: String?
}