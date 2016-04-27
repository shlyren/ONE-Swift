//
//  JENTabBarController.swift
//  ONE_Swift
//
//  Created by 任玉祥 on 16/4/27.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

import UIKit

class JENTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
       
        setupAllVc()
        
    }
    
    // MARK:- 添加所有控制器
    private func setupAllVc() {
        
        setupOneChildVc(vc : JENHomeViewController(),
                      title: "首页",
                      image: "tab_home_default",
                selectedImg: "tab_home_selected")
        
        setupOneChildVc(vc : JENReadViewController(),
                      title: "阅读",
                      image: "tab_reading_default",
                selectedImg: "tab_reading_selected")
        
        setupOneChildVc(vc : JENMusicViewController(),
                      title: "音乐",
                      image: "tab_music_default",
                selectedImg: "tab_music_selected")
        
        setupOneChildVc(vc : JENVideoViewController(),
                      title: "电影",
                      image: "tab_movie_default",
                selectedImg: "tab_movie_selected")
        
        
    }
    
    // MARK:- 添加一个控制器
    private func setupOneChildVc(vc vc : UIViewController, title : String, image : String, selectedImg : String){
        
        vc.tabBarItem.title = title
        vc.tabBarItem.image = UIImage(named: image)?.imageWithRenderingMode(.AlwaysOriginal)
        vc.tabBarItem.selectedImage = UIImage(named: selectedImg)?.imageWithRenderingMode(.AlwaysOriginal)
    
        if vc.isKindOfClass(JENHomeViewController) {
            vc.navigationItem.titleView = UIImageView(image: UIImage(named: "nav_title"))
        } else {
            vc.title = title
        }
        
        addChildViewController(JENNavigationController(rootViewController: vc))
        
    }

}
