//
//  JENLoadData.swift
//  ONE_Swift
//
//  Created by 任玉祥 on 16/4/27.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

import UIKit
import MJExtension
import SVProgressHUD

class JENLoadData: NSObject {
}

// MARK: - 首页数据
extension JENLoadData {
    
    class func loadHomeSubtotal(url: String, completion: (resObj: [JENHomeSubTotalItem]) -> ()) {
        
        let fullUrl = "http://v3.wufazhuce.com:8000/api/hp/" + url
        
        JENNetWorkTool.shareInstance.request(.GET, url: fullUrl, parameters: nil) { (resObj, error) -> () in
            
            if error != nil { print("首页数据加载失败\(error)"); return }
            guard let resObj = resObj as? [String: AnyObject] else { return }
            guard let data = resObj["data"] as? [[String: AnyObject]] else { return }
            
            let result = JENHomeSubTotalItem.mj_objectArrayWithKeyValuesArray(data) as NSArray
            completion(resObj: result as! [JENHomeSubTotalItem])
        }
    }

}

// MARK: - 阅读数据
extension JENLoadData {
    
   // MARK: 阅读轮播数据
    class func loadReadCarouselList(completion: (resObj: [JENReadCarouselListItem]) -> ()) {
       
        JENNetWorkTool.shareInstance.request(.GET, url: "http://v3.wufazhuce.com:8000/api/reading/carousel", parameters: nil) { (resObj, error) in
            
            JENReadCarouselListItem .mj_setupReplacedKeyFromPropertyName({ () -> [NSObject: AnyObject]! in
                return ["carousel_id": "id"]
            })
            
            if error != nil { print("阅读轮播列表数据加载失败\(error!)"); return }
            guard let resObj = resObj as? [String: AnyObject] else { return }
            guard let data = resObj["data"] as? [[String: AnyObject]] else { return }
            
            let result = JENReadCarouselListItem.mj_objectArrayWithKeyValuesArray(data) as NSArray
            completion(resObj: result as! [JENReadCarouselListItem])
        }
    }
    
    // MARK: 阅读轮播点击后的模型
    class func loadReadCarouselDetail(url: String, completion: (resObj: [JENReadCarouselItem]) -> ()) {
        
        let fullUrl = "http://v3.wufazhuce.com:8000/api/reading/carousel/" + url
        JENNetWorkTool.shareInstance.request(.GET, url: fullUrl, parameters: nil) { (resObj, error) in
            
            if error != nil { print("阅读轮播详情数据加载失败\(error)"); return }
            guard let resObj = resObj as? [String: AnyObject] else { return }
            guard let data = resObj["data"] as? [[String: AnyObject]] else { return }

            let result = JENReadCarouselItem.mj_objectArrayWithKeyValuesArray(data) as NSArray
            completion(resObj: result as! [JENReadCarouselItem])
        }
    }
    
    // MARK: 阅读列表数据
    class func loadReadList(completion: (resObj: JENReadListItem) -> ()) {
        JENNetWorkTool.shareInstance.request(.GET, url: "http://v3.wufazhuce.com:8000/api/reading/index", parameters: nil) { (resObj, error) in
            JENReadListItem.mj_setupObjectClassInArray({ () -> [NSObject: AnyObject]! in
                return ["essay": JENReadEssayItem.classForCoder(),
                        "serial": JENReadSerialItem.classForCoder(),
                        "question": JENReadQuestionItem.classForCoder()]
            })
            
            JENReadEssayItem.mj_setupObjectClassInArray({ () -> [NSObject: AnyObject]! in
                return ["author": JENAuthorItem.classForCoder()]
            })
            
            JENReadSerialItem.mj_setupReplacedKeyFromPropertyName({ () -> [NSObject: AnyObject]! in
                return ["content_id": "id"]
            })
            
            if error != nil { print("阅读列表数据加载失败\(error)"); return }
            guard let resObj = resObj as? [String: AnyObject] else { return }
            guard let data = resObj["data"] as? [String: AnyObject] else { return }
            let result = JENReadListItem.mj_objectWithKeyValues(data)
            completion(resObj: result)
        }
    }
    
    // MARK: 短篇详情
    class func loadReadEssayDetail(url: String, completion: (resObj: JENReadEssayDetailItem) -> ()) {
        let fullUrl = "http://v3.wufazhuce.com:8000/api/essay/" + url
        JENNetWorkTool.shareInstance.request(.GET, url: fullUrl, parameters: nil) { (resObj, error) in
            
            JENReadEssayItem.mj_setupObjectClassInArray({ () -> [NSObject: AnyObject]! in
                return ["author": JENAuthorItem.classForCoder()]
            })
            if error != nil { print("短篇详情加载失败\(error)"); return }
            guard let resObj = resObj as? [String: AnyObject] else { return }
            guard let data = resObj["data"] as? [String: AnyObject] else { return }
            let result = JENReadEssayDetailItem.mj_objectWithKeyValues(data)
            completion(resObj: result)

        }
    }
    
    // MARK: 连载详情
    class func loadReadSerialDetail(url: String, completion: (resObj: JENReadSerialDetailItem) -> ()) {
        
        let fullUrl = "http://v3.wufazhuce.com:8000/api/serialcontent/" + url
        JENNetWorkTool.shareInstance.request(.GET, url: fullUrl, parameters: nil) { (resObj, error) in
            JENReadSerialItem.mj_setupReplacedKeyFromPropertyName({ () -> [NSObject: AnyObject]! in
                return ["content_id": "id"]
            })
            
            if error != nil { print("短篇详情加载失败\(error)"); return }
            guard let resObj = resObj as? [String: AnyObject] else { return }
            guard let data = resObj["data"] as? [String: AnyObject] else { return }
            let result = JENReadSerialDetailItem.mj_objectWithKeyValues(data)
            completion(resObj: result)
            
        }
    }
    
    // MARK: 问答详情
    class func loadReadQuestionDetail(url: String, completion: (resObj: JENReadQuestionDetailItem) -> ()) {
        
        let fullUrl = "http://v3.wufazhuce.com:8000/api/question/" + url
        JENNetWorkTool.shareInstance.request(.GET, url: fullUrl, parameters: nil) { (resObj, error) in
            
            if error != nil { print("问答详情加载失败\(error)"); return }
            guard let resObj = resObj as? [String: AnyObject] else { return }
            guard let data = resObj["data"] as? [String: AnyObject] else { return }
            let result = JENReadQuestionDetailItem.mj_objectWithKeyValues(data)
            completion(resObj: result)
            
        }
    }
    
    // MARK: 短篇推荐
    class func loadReadEssayRelated(url: String, completion: (resObj: [JENReadEssayItem]) -> ()) {
         let fullUrl = "http://v3.wufazhuce.com:8000/api/" + url
        JENNetWorkTool.shareInstance.request(.GET, url: fullUrl, parameters: nil) { (resObj, error) in
            
            JENReadEssayItem.mj_setupObjectClassInArray({ () -> [NSObject: AnyObject]! in
                return ["author": JENAuthorItem.classForCoder()]
            })
            if error != nil { print("短篇推荐加载失败\(error)"); return }
            guard let resObj = resObj as? [String: AnyObject] else { return }
            guard let data = resObj["data"] as? [[String: AnyObject]] else { return }
            let result = JENReadEssayItem.mj_objectArrayWithKeyValuesArray(data) as NSArray
            completion(resObj: result as! [JENReadEssayItem])
        }
    }
    
    // MARK: 连载推荐
    class func loadReadSerialRelated(url: String, completion: (resObj: [JENReadSerialItem]) -> ()) {
        let fullUrl = "http://v3.wufazhuce.com:8000/api/" + url
        JENNetWorkTool.shareInstance.request(.GET, url: fullUrl, parameters: nil) { (resObj, error) in
            
            JENReadSerialItem.mj_setupReplacedKeyFromPropertyName({ () -> [NSObject: AnyObject]! in
                return ["content_id": "id"]
            })
            if error != nil { print("连载推荐加载失败\(error)"); return }
            guard let resObj = resObj as? [String: AnyObject] else { return }
            guard let data = resObj["data"] as? [[String: AnyObject]] else { return }
            let result = JENReadSerialItem.mj_objectArrayWithKeyValuesArray(data) as NSArray
            completion(resObj: result as! [JENReadSerialItem])
        }
    }
    
    // MARK: 问答推荐
    class func loadReadQuestionRelated(url: String, completion: (resObj: [JENReadQuestionItem]) -> ()) {
        
        let fullUrl = "http://v3.wufazhuce.com:8000/api/" + url
        JENNetWorkTool.shareInstance.request(.GET, url: fullUrl, parameters: nil) { (resObj, error) in
            
            if error != nil { print("问答推荐加载失败\(error)"); return }
            guard let resObj = resObj as? [String: AnyObject] else { return }
            guard let data = resObj["data"] as? [[String: AnyObject]] else { return }
            let result = JENReadQuestionItem.mj_objectArrayWithKeyValuesArray(data) as NSArray
            completion(resObj: result as! [JENReadQuestionItem])
        }
    }
    
    // MARK: 评论数据
    class func loadComment(url: String, completion: (resObj: [JENCommentItem]) -> ()) {
        let fullUrl = "http://v3.wufazhuce.com:8000/api/comment/praiseandtime/" + url
        
        
        JENNetWorkTool.shareInstance.request(.GET, url: fullUrl, parameters: nil) { (resObj, error) in
            
            JENCommentItem.mj_setupReplacedKeyFromPropertyName({ () -> [NSObject: AnyObject]! in
                return ["comment_id": "id"]
            })
            if error != nil { print("评论数据加载失败\(error)"); return }
            guard let resObj = resObj as? [String: AnyObject] else { return }
            guard let data = resObj["data"]!["data"] as? [[String: AnyObject]] else { return }
            
            let result = JENCommentItem.mj_objectArrayWithKeyValuesArray(data) as NSArray
            completion(resObj: result as! [JENCommentItem])

        }
    }
    
    // MARK: - 连载的列表
    class func loadSerialList(url: String, completion: (resObj: [JENReadSerialItem]) -> ()) {
        
        let fullUrl = "http://v3.wufazhuce.com:8000/api/serial/list/" + url
        
        JENNetWorkTool.shareInstance.request(.GET, url: fullUrl, parameters: nil) { (resObj, error) in
            JENReadSerialItem.mj_setupReplacedKeyFromPropertyName({ () -> [NSObject: AnyObject]! in
                return ["content_id": "id"]
            })
            if error != nil { print("连载列表加载失败\(error)"); return }
            guard let resObj = resObj as? [String: AnyObject] else { return }
            guard let data = resObj["data"] as? [String: AnyObject] else { return }
            guard let list = data["list"] as? [[String: AnyObject]] else { return }
            let result = JENReadSerialItem.mj_objectArrayWithKeyValuesArray(list) as NSArray
            completion(resObj: result as! [JENReadSerialItem])
        }
    }
}


// MARK: - 电影数据
extension JENLoadData {
    
    // MARK: 电影列表数据
    class func loadMovieList(detail_id: String, completion: (resObj: [JENMovieListItem]) -> ()) {
        let fullUrl = "http://v3.wufazhuce.com:8000/api/movie/list/" + detail_id
        
        JENNetWorkTool.shareInstance.request(.GET, url: fullUrl
            , parameters: nil) { (resObj, error) in
                JENMovieListItem.mj_setupReplacedKeyFromPropertyName({ () -> [NSObject : AnyObject]! in
                    return ["detail_id" : "id"]
                })
                
                if error != nil { print("电影列表数据加载失败\(error)"); return }
                guard let resObj = resObj as? [String: AnyObject] else { return }
                guard let data = resObj["data"] as? [[String: AnyObject]] else { return }
                
                let result = JENMovieListItem.mj_objectArrayWithKeyValuesArray(data) as NSArray
                completion(resObj: result as! [JENMovieListItem])
        }
    }
    
    // MARK: 电影详情
    class func loadMovieDetail(detail_id: String, completion: (resObj: JENMovieDetailItem) -> ()) {
        let fullUrl = "http://v3.wufazhuce.com:8000/api/movie/detail/" + detail_id
        
        JENNetWorkTool.shareInstance.request(.GET, url: fullUrl, parameters: nil) { (resObj, error) in
            JENMovieListItem.mj_setupReplacedKeyFromPropertyName({ () -> [NSObject : AnyObject]! in
                return ["detail_id" : "id"]
            })
            
            if error != nil { print("电影详情数据加载失败\(error)"); return }
            guard let resObj = resObj as? [String: AnyObject] else { return }
            guard let data = resObj["data"] as? [String: AnyObject] else { return }
            
            let result = JENMovieDetailItem.mj_objectWithKeyValues(data)
            completion(resObj: result)

        }
    }
    
    // MARK: 电影故事
    class func loadMovieStory(detail_id: String, completion: (resObj: JENMovieStroyResult) -> ()) {
        let fullUrl = "http://v3.wufazhuce.com:8000/api/movie/" + detail_id + "/story/1/0"
        
        JENNetWorkTool.shareInstance.request(.GET, url: fullUrl, parameters: nil) { (resObj, error) in
            JENMovieStoryItem.mj_setupReplacedKeyFromPropertyName({ () -> [NSObject : AnyObject]! in
                return ["story_id" : "id"]
            })
            
            JENMovieStroyResult.mj_setupObjectClassInArray({ () -> [NSObject : AnyObject]! in
                return["data" : JENMovieStoryItem.classForCoder()]
            })
            
            if error != nil { print("电影故事数据加载失败\(error)"); return }
            guard let resObj = resObj as? [String: AnyObject] else { return }
            guard let data = resObj["data"] as? [String: AnyObject] else { return }
            let result = JENMovieStroyResult.mj_objectWithKeyValues(data)
            
            completion(resObj: result)
            
        }
    }

}














