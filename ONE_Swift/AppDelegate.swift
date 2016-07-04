//
//  AppDelegate.swift
//  ONE_Swift
//
//  Created by 任玉祥 on 16/4/27.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

import UIKit
import SDWebImage
import SVProgressHUD

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private var timer: Timer?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.rootViewController = JENTabBarController()
        window?.backgroundColor = UIColor.whiteColor()
        window?.makeKeyAndVisible()
        
        SVProgressHUD.setMinimumDismissTimeInterval(1.0)
        
        window?.addSubview(JENFPSLabel(frame: CGRectMake(15, JENScreenHeight - 50, 0, 0)))
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        
    }

    func applicationDidEnterBackground(application: UIApplication) {
        stopTimer()
    }

    func applicationWillEnterForeground(application: UIApplication) {
        
    }

    func applicationDidBecomeActive(application: UIApplication) {
        startTimer()
    }

    func applicationWillTerminate(application: UIApplication) {
        
    }
    
    func applicationDidReceiveMemoryWarning(application: UIApplication) {
        clearMemory()
    }


}

private extension AppDelegate {
    func startTimer() {
        timer = NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: #selector(clearMemory), userInfo: nil, repeats: true)
    }
    
    func stopTimer() {
        if let timer = timer {
            timer.invalidate()
        }
         timer = nil
    }
    
    @objc func clearMemory() {
        SDImageCache.sharedImageCache().clearMemory()
    }
}
