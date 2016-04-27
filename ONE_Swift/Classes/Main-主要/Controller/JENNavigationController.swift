//
//  JENNavigationController.swift
//  ONE_Swift
//
//  Created by 任玉祥 on 16/4/27.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

import UIKit

class JENNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
    
    
    }
    
    
    override func pushViewController(viewController: UIViewController, animated: Bool) {
        
        if self.childViewControllers.count > 0 {
            
            viewController.hidesBottomBarWhenPushed = true;

        } else {
            
            viewController.navigationItem.leftBarButtonItem = setupNavItem(image: "nav_search_default", frame: CGRectMake(0, 15, 20, 20), action: "leftBtnClick")
            
            viewController.navigationItem.rightBarButtonItem = setupNavItem(image: "nav_me_default", frame: CGRectMake(30, 15, 20, 20), action: "rightBtnClick")
            
            
        }
        
        super.pushViewController(viewController, animated: animated)
    }
    
    // MARK:- 导航栏按钮
    private func setupNavItem(image image : String, frame : CGRect, action : Selector) -> (UIBarButtonItem) {
        
        let bigBtn = UIButton(frame: CGRectMake(0, 0, 50, 50))
        let smallBtn = UIButton(frame: frame)
        
        smallBtn.userInteractionEnabled = false;
        smallBtn.setImage(UIImage(named: image), forState: .Normal)
        
        bigBtn.addTarget(self, action: action, forControlEvents: .TouchUpInside)
        bigBtn.addSubview(smallBtn)
        
        return UIBarButtonItem(customView: bigBtn)
        
        
    }
    
    // MARK:- 按钮点击事件
    @objc private func leftBtnClick() {
        print("左边按钮点击")
    }
    
    @objc private func rightBtnClick() {
        print("右边按钮点击")
    }

}
