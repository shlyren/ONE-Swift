//
//  JENHomeSubTotalItem.swift
//  ONE_Swift
//
//  Created by 任玉祥 on 16/4/28.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

import UIKit

/*
"hpcontent_id"     :"1323",
"hp_title"         :"VOL.1299",
"author_id"        :"-1",
"hp_img_url"       :"http://image.wufazhuce.com/FkrRz_CMdgrrd4-P4CQ4loTH0mMV",
"hp_img_original_url":"http://image.wufazhuce.com/FkrRz_CMdgrrd4-P4CQ4loTH0mMV",
"hp_author"        :"睡了吗？摘颗星星给你&lost7 作品",
"ipad_url"         :"http://image.wufazhuce.com/FnEUJ2bXo2dFaA8sWBHB06mlmqvW",
"hp_content"        :"所谓青春就是尚未得到某种东西的状态，就是渴望的状态，憧憬的状态，也是具有可能性的状态。他们眼前展现着人生广袤的原野和恐惧，尽管他们还一无所有，但他们偶尔也能在幻想中具有一种拥有一切的感觉。by 三岛由纪夫",
"hp_makettime"     :"2016-04-27 23:00:00",
"last_update_date" :"2016-04-21 14:08:32",
"web_url"          :"http://m.wufazhuce.com/one/1323",
"wb_img_url":"",
"praisenum"        :11832,
"sharenum"         :1783,
"commentnum"       :352
 */

// MARK: - 首页模型
class JENHomeSubTotalItem : NSObject {
    var hpcontent_id: String?
    var hp_title: String?
    var author_id: String?
    var hp_img_url: String?
    var hp_author: String?
    var hp_content: String?
    var hp_makettime: String?
    var praisenum = 0
    var sharenum = 0
    var commentnum = 0

    
//    var hp_img_original_url: String?
//    var ipad_url: String?
//    var last_update_date: String?
//    var web_url: String?
    
}
