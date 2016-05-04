//
//  JENLoadData.swift
//  ONE_Swift
//
//  Created by 任玉祥 on 16/4/27.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

import UIKit
import MJExtension

class JENLoadData: NSObject {
}

// MARK: - 首页数据
extension JENLoadData {
    
    class func loadHomeSubtotal(url : String, completion : (responseObject : [JENHomeSubTotalItem]) -> ()) {
        
        let fullUrl = "http://v3.wufazhuce.com:8000/api/hp/" + url
        
        JENNetWorkTool.shareInstance.request(.GET, url: fullUrl, parameters: nil) { (responseObject, error) -> () in
            
            if error != nil { print("首页数据加载失败\(error)"); return }
            guard let responseObject = responseObject as? [String : AnyObject] else { return }
            guard let data = responseObject["data"] as? [[String : AnyObject]] else { return }
            
            let result = JENHomeSubTotalItem.mj_objectArrayWithKeyValuesArray(data) as NSArray
            completion(responseObject: result as! [JENHomeSubTotalItem])
        }
    }

}

// MARK: - 阅读数据
extension JENLoadData {
    
    /**
     阅读轮播数据
     */
    class func loadReadCarouselList(completion : (responseObject : [JENReadCarouselListItem]) -> ()) {
       
        JENNetWorkTool.shareInstance.request(.GET, url: "http://v3.wufazhuce.com:8000/api/reading/carousel", parameters: nil) { (responseObject, error) in
            
            JENReadCarouselListItem .mj_setupReplacedKeyFromPropertyName({ () -> [NSObject : AnyObject]! in
                return ["carousel_id" : "id"]
            })
            
            if error != nil { print("阅读轮播列表数据加载失败\(error!)"); return }
            guard let responseObject = responseObject as? [String : AnyObject] else { return }
            guard let data = responseObject["data"] as? [[String : AnyObject]] else { return }
            
            let result = JENReadCarouselListItem.mj_objectArrayWithKeyValuesArray(data) as NSArray
            completion(responseObject: result as! [JENReadCarouselListItem])
        }
    }
    
    /**
     阅读轮播点击后的模型
     */
    class func loadReadCarouselDetail(url : String, completion : (responseObject : [JENReadCarouselItem]) -> ()) {
        
        let fullUrl = "http://v3.wufazhuce.com:8000/api/reading/carousel/" + url
        JENNetWorkTool.shareInstance.request(.GET, url: fullUrl, parameters: nil) { (responseObject, error) in
            
            if error != nil { print("阅读轮播详情数据加载失败\(error)"); return }
            guard let responseObject = responseObject as? [String : AnyObject] else { return }
            guard let data = responseObject["data"] as? [[String : AnyObject]] else { return }

            let result = JENReadCarouselItem.mj_objectArrayWithKeyValuesArray(data) as NSArray
            completion(responseObject: result as! [JENReadCarouselItem])
        }
    }
    
    /**
     阅读列表数据
     */
    class func loadReadList(completion : (responseObject : JENReadListItem) -> ()) {
        JENNetWorkTool.shareInstance.request(.GET, url: "http://v3.wufazhuce.com:8000/api/reading/index", parameters: nil) { (responseObject, error) in
            JENReadListItem.mj_setupObjectClassInArray({ () -> [NSObject : AnyObject]! in
                return ["essay" : JENReadEssayItem.classForCoder(),
                        "serial" : JENReadSerialItem.classForCoder(),
                        "question" : JENReadQuestionItem.classForCoder()]
            })
            
            JENReadEssayItem.mj_setupObjectClassInArray({ () -> [NSObject : AnyObject]! in
                return ["author" : JENAuthorItem.classForCoder()]
            })
            
            JENReadSerialItem.mj_setupReplacedKeyFromPropertyName({ () -> [NSObject : AnyObject]! in
                return ["content_id" : "id"]
            })
            
            if error != nil { print("阅读列表数据加载失败\(error)"); return }
            guard let responseObject = responseObject as? [String : AnyObject] else { return }
            guard let data = responseObject["data"] as? [String : AnyObject] else { return }
            let result = JENReadListItem.mj_objectWithKeyValues(data)
            completion(responseObject: result)
        }
    }
    
    
    /**
     短篇详情
     */
    class func loadReadEssayDetail(url : String, completion : (responseObject : JENReadEssayDetailItem) -> ()) {
        let fullUrl = "http://v3.wufazhuce.com:8000/api/essay/" + url
        JENNetWorkTool.shareInstance.request(.GET, url: fullUrl, parameters: nil) { (responseObject, error) in
            
            JENReadEssayItem.mj_setupObjectClassInArray({ () -> [NSObject : AnyObject]! in
                return ["author" : JENAuthorItem.classForCoder()]
            })
            if error != nil { print("短篇详情加载失败\(error)"); return }
            guard let responseObject = responseObject as? [String : AnyObject] else { return }
            guard let data = responseObject["data"] as? [String : AnyObject] else { return }
            let result = JENReadEssayDetailItem.mj_objectWithKeyValues(data)
            completion(responseObject: result)

        }
    }
    
    /**
     连载详情
     */
    class func loadReadSerialDetail(url : String, completion : (responseObject : JENReadSerialDetailItem) -> ()) {
        
        let fullUrl = "http://v3.wufazhuce.com:8000/api/serialcontent/" + url
        JENNetWorkTool.shareInstance.request(.GET, url: fullUrl, parameters: nil) { (responseObject, error) in
            JENReadSerialItem.mj_setupReplacedKeyFromPropertyName({ () -> [NSObject : AnyObject]! in
                return ["content_id" : "id"]
            })
            
            if error != nil { print("短篇详情加载失败\(error)"); return }
            guard let responseObject = responseObject as? [String : AnyObject] else { return }
            guard let data = responseObject["data"] as? [String : AnyObject] else { return }
            let result = JENReadSerialDetailItem.mj_objectWithKeyValues(data)
            completion(responseObject: result)
            
        }
    }
    
    /**
     问答详情
     */
    class func loadReadQuestionDetail(url : String, completion : (responseObject : JENReadQuestionDetailItem) -> ()) {
        
        let fullUrl = "http://v3.wufazhuce.com:8000/api/question/" + url
        JENNetWorkTool.shareInstance.request(.GET, url: fullUrl, parameters: nil) { (responseObject, error) in
            
            if error != nil { print("问答详情加载失败\(error)"); return }
            guard let responseObject = responseObject as? [String : AnyObject] else { return }
            guard let data = responseObject["data"] as? [String : AnyObject] else { return }
            let result = JENReadQuestionDetailItem.mj_objectWithKeyValues(data)
            completion(responseObject: result)
            
        }
    }
}
















