//
//  JENMovieItem.swift
//  ONE_Swift
//
//  Created by 任玉祥 on 16/5/11.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

import UIKit

// MARK: - 电影列表模型
class JENMovieListItem: NSObject {
     /// id
    var detail_id: String?
     /// 标题
    var title: String?
     /// 评分
    var score: String?
     /// 图片url
    var cover: String?
    
//    var releasetime: String?
//    var scoretime: String?
//    var servertime: Int = 0
    
//    var revisedscore: String?
//    var verse: String?
//    var verse_en: String?
}

// MARK: - 详情模型
class JENMovieDetailItem: JENMovieListItem {

    var detailcover: String?

    var keywords: String?
    var movie_id: String?
    var info: String?

    var charge_edt: String?

    var praisenum = 0
    var sort: String?

    var maketime: String?
    var photo = [String]()
    var sharenum = 0
    var commentnum = 0
    var servertime = 0
    
//    var indexcover: String?
//    var video: String?
//    var review: String?
//    var officialstory: String?
//    var web_url: String?
//    var releasetime: String?
//    var scoretime: String?
    
//    var last_update_date: String?
//    var read_num: String?
//    var push_id: String?
}

class JENMovieStroyResult: NSObject {
    var count = 0
    
    var data = [JENMovieStoryItem]()
    
    
}

class JENMovieStoryItem: NSObject {
     /// id
    var story_id: String?
    
    var movie_id: String?
    var title: String?
    var content: String?
    var user_id: String?
    
    var sort: String?
    var praisenum = 0
    var input_date: String?
    var story_type: String?
    var user = JENAuthorItem()
}