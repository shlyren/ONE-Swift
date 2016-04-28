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
    
    static let shareInstance = JENLoadData()

    /// 首页数据
    func loadHomeSubtotal(url : String, completion : (responseObject : NSArray) -> ()) {
        
        let fullUrl = "http://v3.wufazhuce.com:8000/api/hp/" + url
        
        JENNetWorkTool.shareInstance.request(.GET, url: fullUrl, parameters: nil) { (responseObject, error) -> () in
            
            if error != nil {
                print("首页数据加载失败\(error)")
            }
            
            guard let responseObject = responseObject as? [String : AnyObject] else {
                print("首页数据加载失败,数据为空")
                return
            }
            
            let result = JENHomeSubTotalItem.mj_objectArrayWithKeyValuesArray(responseObject["data"] as? [[String : AnyObject]])
            
            completion(responseObject: result)
        }
    }
    


}
