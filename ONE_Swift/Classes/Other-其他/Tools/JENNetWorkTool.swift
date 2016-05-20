//
//  JENNetWorkTool.swift
//  ONE_Swift
//
//  Created by 任玉祥 on 16/4/27.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

import AFNetworking
import SVProgressHUD

enum RequestType {
    case GET
    case POST
}

class JENNetWorkTool: AFHTTPSessionManager {
    static let shareInstance: JENNetWorkTool = {
        
        let tool = JENNetWorkTool()

        return tool
    }()
}

extension JENNetWorkTool {
    
    func request(requestType: RequestType, url: String, parameters: [String: AnyObject]?, completion: (resObj: AnyObject?, error: NSError?) -> ()) {
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true;
        SVProgressHUD.show()
        /// 成功的闭包
        let successCallBack = { (task: NSURLSessionDataTask, resObj: AnyObject?) -> Void in
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false;
            SVProgressHUD.dismiss()
           
            completion(resObj: resObj, error: nil)
        }
        /// 失败的闭包
        let failureCallBack = { (task: NSURLSessionDataTask?, error: NSError) -> Void in
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false;
            SVProgressHUD.dismiss()
            completion(resObj: nil, error: error)
        }
        
        
        if requestType == .GET {

            GET(url, parameters: parameters, progress: nil, success: successCallBack, failure: failureCallBack)
            
        }else {
            POST(url, parameters: parameters, progress: nil, success: successCallBack, failure: failureCallBack)
        }
    
    }
    
}
