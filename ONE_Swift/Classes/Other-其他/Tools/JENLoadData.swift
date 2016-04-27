//
//  JENLoadData.swift
//  ONE_Swift
//
//  Created by 任玉祥 on 16/4/27.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

import UIKit

class JENLoadData: NSObject {


    func loadHomeSubtotal(url : String, completion : (responseObject : AnyObject?, error : NSError?) -> ()) {
        
        JENNetWorkTool.shareIntance.request(.GET, url: url, parameters: nil) { (responseObject, error) -> () in
            
        }
        
    }
    
}
