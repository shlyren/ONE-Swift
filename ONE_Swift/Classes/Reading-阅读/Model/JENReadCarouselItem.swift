//
//  JENReadCarouselItem.swift
//  ONE_Swift
//
//  Created by 任玉祥 on 16/5/2.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

import UIKit

// MARK: - 轮播列表模型
class JENReadCarouselListItem : NSObject {
     /// id
    var carousel_id: String?
     /// 标题
    var title: String?
     /// 图片
    var cover: String?
     /// 背景颜色
    var bgcolor: String?
     /// 底部文字
    var bottom_text: String?
    
    //var pv_url: String?
}

// MARK: - 轮播主题模型
class JENReadCarouselItem : NSObject {
     /// item id
    var item_id: String?
     /// 标题
    var title: String?
     /// 内容
    var introduction: String?
     /// 作者
    var author: String?
     ///
    var number = ""
     /// 类型
    var type = 0
    
    var readType: JENReadType {
        get {
            var readType = JENReadType.Unknow
            switch type {
                case 1:
                    readType = .Essay
                case 2:
                    readType = .Serial
                case 3:
                    readType = .Question
                default:
                    readType = .Unknow
            }
            return readType
        }
    }
}