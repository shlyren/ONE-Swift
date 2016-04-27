//
//  JENNetWorkTool.swift
//  ONE_Swift
//
//  Created by 任玉祥 on 16/4/27.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

import AFNetworking

enum RequestType {
    case GET
    case POST
}

class JENNetWorkTool: AFHTTPSessionManager {
    static let shareIntance : JENNetWorkTool = {
        
        let tool = JENNetWorkTool()

        return tool
    }()
}

extension JENNetWorkTool {
    
    func request(requestType : RequestType, url : String, parameters : [String : AnyObject]?, completion : (responseObject : AnyObject?, error : NSError?) -> ()) {
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true;
        
        /// 成功的闭包
        let successCallBack = { (task : NSURLSessionDataTask, responseObject : AnyObject?) -> Void in
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false;
            completion(responseObject: responseObject, error: nil)
        }
        /// 失败的闭包
        let failureCallBack = { (task : NSURLSessionDataTask?, error : NSError) -> Void in
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false;
            completion(responseObject: nil, error: error)
        }
        
        
        if requestType == .GET {

            GET(url, parameters: nil, progress: nil, success: successCallBack, failure: failureCallBack)
            
        }else {
            POST(url, parameters: parameters, progress: nil, success: successCallBack, failure: failureCallBack)

        }
    
    }
    
}