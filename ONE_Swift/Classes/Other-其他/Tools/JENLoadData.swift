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

class JENLoadData : NSObject {
}

// MARK: - 首页数据
extension JENLoadData {
    
    class func loadHomeSubtotal(url: String, completion: (responseObject: [JENHomeSubTotalItem]) -> ()) {
        
        let fullUrl = "http://v3.wufazhuce.com:8000/api/hp/" + url
        
        JENNetWorkTool.shareInstance.request(.GET, url: fullUrl, parameters: nil) { (responseObject, error) -> () in
            
            if error != nil { print("首页数据加载失败\(error)"); return }
            guard let responseObject = responseObject as? [String: AnyObject] else { return }
            guard let data = responseObject["data"] as? [[String: AnyObject]] else { return }
            
            let result = JENHomeSubTotalItem.mj_objectArrayWithKeyValuesArray(data) as NSArray
            completion(responseObject: result as! [JENHomeSubTotalItem])
        }
    }

}

// MARK: - 阅读数据
extension JENLoadData {
    
   // MARK: 阅读轮播数据
    class func loadReadCarouselList(completion: (responseObject: [JENReadCarouselListItem]) -> ()) {
       
        JENNetWorkTool.shareInstance.request(.GET, url: "http://v3.wufazhuce.com:8000/api/reading/carousel", parameters: nil) { (responseObject, error) in
            
            JENReadCarouselListItem .mj_setupReplacedKeyFromPropertyName({ () -> [NSObject: AnyObject]! in
                return ["carousel_id": "id"]
            })
            
            if error != nil { print("阅读轮播列表数据加载失败\(error!)"); return }
            guard let responseObject = responseObject as? [String: AnyObject] else { return }
            guard let data = responseObject["data"] as? [[String: AnyObject]] else { return }
            
            let result = JENReadCarouselListItem.mj_objectArrayWithKeyValuesArray(data) as NSArray
            completion(responseObject: result as! [JENReadCarouselListItem])
        }
    }
    
    // MARK: 阅读轮播点击后的模型
    class func loadReadCarouselDetail(url: String, completion: (responseObject: [JENReadCarouselItem]) -> ()) {
        
        let fullUrl = "http://v3.wufazhuce.com:8000/api/reading/carousel/" + url
        JENNetWorkTool.shareInstance.request(.GET, url: fullUrl, parameters: nil) { (responseObject, error) in
            
            if error != nil { print("阅读轮播详情数据加载失败\(error)"); return }
            guard let responseObject = responseObject as? [String: AnyObject] else { return }
            guard let data = responseObject["data"] as? [[String: AnyObject]] else { return }

            let result = JENReadCarouselItem.mj_objectArrayWithKeyValuesArray(data) as NSArray
            completion(responseObject: result as! [JENReadCarouselItem])
        }
    }
    
    // MARK: 阅读列表数据
    class func loadReadList(completion: (responseObject: JENReadListItem) -> ()) {
        JENNetWorkTool.shareInstance.request(.GET, url: "http://v3.wufazhuce.com:8000/api/reading/index", parameters: nil) { (responseObject, error) in
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
            guard let responseObject = responseObject as? [String: AnyObject] else { return }
            guard let data = responseObject["data"] as? [String: AnyObject] else { return }
            let result = JENReadListItem.mj_objectWithKeyValues(data)
            completion(responseObject: result)
        }
    }
    
    // MARK: 短篇详情
    class func loadReadEssayDetail(url: String, completion: (responseObject: JENReadEssayDetailItem) -> ()) {
        let fullUrl = "http://v3.wufazhuce.com:8000/api/essay/" + url
        JENNetWorkTool.shareInstance.request(.GET, url: fullUrl, parameters: nil) { (responseObject, error) in
            
            JENReadEssayItem.mj_setupObjectClassInArray({ () -> [NSObject: AnyObject]! in
                return ["author": JENAuthorItem.classForCoder()]
            })
            if error != nil { print("短篇详情加载失败\(error)"); return }
            guard let responseObject = responseObject as? [String: AnyObject] else { return }
            guard let data = responseObject["data"] as? [String: AnyObject] else { return }
            let result = JENReadEssayDetailItem.mj_objectWithKeyValues(data)
            completion(responseObject: result)

        }
    }
    
    // MARK: 连载详情
    class func loadReadSerialDetail(url: String, completion: (responseObject: JENReadSerialDetailItem) -> ()) {
        
        let fullUrl = "http://v3.wufazhuce.com:8000/api/serialcontent/" + url
        JENNetWorkTool.shareInstance.request(.GET, url: fullUrl, parameters: nil) { (responseObject, error) in
            JENReadSerialItem.mj_setupReplacedKeyFromPropertyName({ () -> [NSObject: AnyObject]! in
                return ["content_id": "id"]
            })
            
            if error != nil { print("短篇详情加载失败\(error)"); return }
            guard let responseObject = responseObject as? [String: AnyObject] else { return }
            guard let data = responseObject["data"] as? [String: AnyObject] else { return }
            let result = JENReadSerialDetailItem.mj_objectWithKeyValues(data)
            completion(responseObject: result)
            
        }
    }
    
    // MARK: 问答详情
    class func loadReadQuestionDetail(url: String, completion: (responseObject: JENReadQuestionDetailItem) -> ()) {
        
        let fullUrl = "http://v3.wufazhuce.com:8000/api/question/" + url
        JENNetWorkTool.shareInstance.request(.GET, url: fullUrl, parameters: nil) { (responseObject, error) in
            
            if error != nil { print("问答详情加载失败\(error)"); return }
            guard let responseObject = responseObject as? [String: AnyObject] else { return }
            guard let data = responseObject["data"] as? [String: AnyObject] else { return }
            let result = JENReadQuestionDetailItem.mj_objectWithKeyValues(data)
            completion(responseObject: result)
            
        }
    }
    
    // MARK: 短篇推荐
    class func loadReadEssayRelated(url: String, completion: (responseObject: [JENReadEssayItem]) -> ()) {
         let fullUrl = "http://v3.wufazhuce.com:8000/api/" + url
        JENNetWorkTool.shareInstance.request(.GET, url: fullUrl, parameters: nil) { (responseObject, error) in
            
            JENReadEssayItem.mj_setupObjectClassInArray({ () -> [NSObject: AnyObject]! in
                return ["author": JENAuthorItem.classForCoder()]
            })
            if error != nil { print("短篇推荐加载失败\(error)"); return }
            guard let responseObject = responseObject as? [String: AnyObject] else { return }
            guard let data = responseObject["data"] as? [[String: AnyObject]] else { return }
            let result = JENReadEssayItem.mj_objectArrayWithKeyValuesArray(data) as NSArray
            completion(responseObject: result as! [JENReadEssayItem])
        }
    }
    
    // MARK: 连载推荐
    class func loadReadSerialRelated(url: String, completion: (responseObject: [JENReadSerialItem]) -> ()) {
        let fullUrl = "http://v3.wufazhuce.com:8000/api/" + url
        JENNetWorkTool.shareInstance.request(.GET, url: fullUrl, parameters: nil) { (responseObject, error) in
            
            JENReadSerialItem.mj_setupReplacedKeyFromPropertyName({ () -> [NSObject: AnyObject]! in
                return ["content_id": "id"]
            })
            if error != nil { print("连载推荐加载失败\(error)"); return }
            guard let responseObject = responseObject as? [String: AnyObject] else { return }
            guard let data = responseObject["data"] as? [[String: AnyObject]] else { return }
            let result = JENReadSerialItem.mj_objectArrayWithKeyValuesArray(data) as NSArray
            completion(responseObject: result as! [JENReadSerialItem])
        }
    }
    
    // MARK: 问答推荐
    class func loadReadQuestionRelated(url: String, completion: (responseObject: [JENReadQuestionItem]) -> ()) {
        
        let fullUrl = "http://v3.wufazhuce.com:8000/api/" + url
        JENNetWorkTool.shareInstance.request(.GET, url: fullUrl, parameters: nil) { (responseObject, error) in
            
            if error != nil { print("问答推荐加载失败\(error)"); return }
            guard let responseObject = responseObject as? [String: AnyObject] else { return }
            guard let data = responseObject["data"] as? [[String: AnyObject]] else { return }
            let result = JENReadQuestionItem.mj_objectArrayWithKeyValuesArray(data) as NSArray
            completion(responseObject: result as! [JENReadQuestionItem])
        }
    }
    
    // MARK: 评论数据
    class func loadComment(url: String, completion: (responseObject: [JENCommentItem]) -> ()) {
        let fullUrl = "http://v3.wufazhuce.com:8000/api/comment/praiseandtime/" + url
        
        
        JENNetWorkTool.shareInstance.request(.GET, url: fullUrl, parameters: nil) { (responseObject, error) in
            
            JENCommentItem.mj_setupReplacedKeyFromPropertyName({ () -> [NSObject : AnyObject]! in
                return ["comment_id" : "id"]
            })
            if error != nil { print("评论数据加载失败\(error)"); return }
            guard let responseObject = responseObject as? [String: AnyObject] else { return }
            guard let data = responseObject["data"]!["data"] as? [[String: AnyObject]] else { return }
            
            let result = JENCommentItem.mj_objectArrayWithKeyValuesArray(data) as NSArray
            completion(responseObject: result as! [JENCommentItem])

        }
    }
    
    class func loadSerialList(url: String, completion: (responseObject: [JENReadSerialItem]) -> ()) {
        let fullUrl = "http://v3.wufazhuce.com:8000/api/serial/list/" + url
        
        JENNetWorkTool.shareInstance.request(.GET, url: fullUrl, parameters: nil) { (responseObject, error) in
            JENReadSerialItem.mj_setupReplacedKeyFromPropertyName({ () -> [NSObject: AnyObject]! in
                return ["content_id": "id"]
            })
            if error != nil { print("连载列表加载失败\(error)"); return }
            guard let responseObject = responseObject as? [String: AnyObject] else { return }
            guard let data = responseObject["data"] as? [String: AnyObject] else { return }
            guard let list = data["list"] as? [[String: AnyObject]] else { return }
            let result = JENReadSerialItem.mj_objectArrayWithKeyValuesArray(list) as NSArray
            completion(responseObject: result as! [JENReadSerialItem])
        }
        
    }
}
















