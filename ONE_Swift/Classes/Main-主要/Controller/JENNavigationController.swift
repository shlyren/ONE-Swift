//
//  JENNavigationController.swift
//  ONE_Swift
//
//  Created by 任玉祥 on 16/4/27.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

import UIKit
import SVProgressHUD

class JENNavigationController: UINavigationController, UIGestureRecognizerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.enabled = false
        
        let pan = UIPanGestureRecognizer(target: self.interactivePopGestureRecognizer?.delegate, action: #selector(handleNavigationTransition(_:)))
        pan.delegate = self
        view.addGestureRecognizer(pan)
    }
}

extension JENNavigationController {
    
    override func popViewControllerAnimated(animated: Bool) -> UIViewController? {
        SVProgressHUD.dismiss()
        return super.popViewControllerAnimated(animated)
    }
    
    override func pushViewController(viewController: UIViewController, animated: Bool) {
        
        if childViewControllers.count > 0 {
            
            viewController.hidesBottomBarWhenPushed = true;
            
            viewController.navigationItem.leftBarButtonItem = setupBackBtn()
            
        } else {
            
            viewController.navigationItem.leftBarButtonItem = setupNavItem(image: "nav_search_default", frame: CGRectMake(0, 15, 20, 20), action: #selector(leftBtnClick))
            
            viewController.navigationItem.rightBarButtonItem = setupNavItem(image: "nav_me_default", frame: CGRectMake(30, 15, 20, 20), action: #selector(rightBtnClick))
        }
        
        super.pushViewController(viewController, animated: animated)
    }
    
    // MARK: 手势返回
    func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
        return childViewControllers.count > 1
    }
    
    @objc private func handleNavigationTransition(pan: UIPanGestureRecognizer) {}
}

// MARK: - 按钮点击
private extension JENNavigationController {
    // MARK: 返回按钮点击事件
    @objc private func backBtnClick() {
        popViewControllerAnimated(true)
    }
    
    // MARK: 按钮点击事件
    @objc private func leftBtnClick() {
        print("左边按钮点击")
    }
    
    @objc private func rightBtnClick() {
        print("右边按钮点击")
    }
}

// MARK: - 按钮
private extension JENNavigationController {
    // MARK: 返回按钮
    func setupBackBtn() -> UIBarButtonItem {
        
        let backBtn = UIButton(type: .Custom)
        backBtn.setTitle("返回", forState: .Normal)
        backBtn.setTitleColor(UIColor.darkGrayColor(), forState: .Normal)
        backBtn.setImage(UIImage(named: "back"), forState: .Normal)
        backBtn.sizeToFit()
        
        backBtn.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0)
        backBtn.addTarget(self, action: #selector(backBtnClick), forControlEvents: .TouchUpInside)
        
        return UIBarButtonItem(customView: backBtn)
    }
    
    // MARK: 导航栏按钮
    func setupNavItem(image image: String, frame: CGRect, action: Selector) -> (UIBarButtonItem) {
        
        let bigBtn = UIButton(frame: CGRectMake(0, 0, 50, 50))
        let smallBtn = UIButton(frame: frame)
        
        smallBtn.userInteractionEnabled = false;
        smallBtn.setImage(UIImage(named: image), forState: .Normal)
        
        bigBtn.addTarget(self, action: action, forControlEvents: .TouchUpInside)
        bigBtn.addSubview(smallBtn)
        
        return UIBarButtonItem(customView: bigBtn)
    }
}
