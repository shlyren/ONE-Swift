//
//  JENOneItem.swift
//  ONE_Swift
//
//  Created by 任玉祥 on 16/5/4.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

import UIKit

// MARK: - 用户模型
class JENAuthorItem : NSObject {
    var user_id: String?
    var user_name: String?
    var web_url: String?
    var desc: String?
    var wb_name: String?
}

// MARK: - 评论模型
class JENCommentItem : NSObject {
    // 服务器 id
    var comment_id: String?
    var quote: String?
    var content: String?
    var praisenum = 0
    var input_date: String?
    var user = JENAuthorItem()
    var touser: String?
    var type = 0
}
