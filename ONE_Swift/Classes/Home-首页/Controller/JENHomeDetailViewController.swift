//
//  JENHomeDetailViewController.swift
//  ONE_Swift
//
//  Created by 任玉祥 on 16/4/28.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

import UIKit
import SDWebImage

class JENHomeDetailViewController: UIViewController {
    @IBOutlet weak var shareBtn: UIButton!
    @IBOutlet weak var praiseBtn: UIButton!
    @IBOutlet weak var hp_img_url: UIImageView!
    @IBOutlet weak var hp_title_label: UILabel!
    @IBOutlet weak var hp_maketime_label: UILabel!
    @IBOutlet weak var hp_author_label: UILabel!
    @IBOutlet weak var hp_content_label: UILabel!
    
    
    var homeSubTotalItem = JENHomeSubTotalItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()

        title = homeSubTotalItem.hp_title

        setupData()
    }

    // MARK:- 设置数据
    func setupData() {
        hp_title_label.text = homeSubTotalItem.hp_title
        hp_maketime_label.text = homeSubTotalItem.hp_makettime
        hp_author_label.text = homeSubTotalItem.hp_author
        hp_content_label.text = homeSubTotalItem.hp_content
        hp_img_url.sd_setImageWithURL(NSURL(string: homeSubTotalItem.hp_img_url), placeholderImage: UIImage(named: "home"))
        shareBtn.setTitle("\(homeSubTotalItem.sharenum)", forState: .Normal)
        shareBtn.setTitle("\(homeSubTotalItem.sharenum)", forState: .Highlighted)
        praiseBtn.setTitle("\(homeSubTotalItem.praisenum)", forState: .Normal)
        praiseBtn.setTitle("\(homeSubTotalItem.praisenum)", forState: .Highlighted)
    }

    // MARK:- 拖拽手势
    @IBAction func pan(pan : UIPanGestureRecognizer) {
        
        let point = pan.translationInView(pan.view)
        pan.view?.center.x += point.x
        pan.view?.center.y += point.y
        
        if pan.state == .Ended {
            
            UIView.animateWithDuration(1, delay: 0, usingSpringWithDamping: 0.175, initialSpringVelocity: 0, options: .CurveLinear, animations: { () -> Void in
                pan.view?.center = self.view.center
                }, completion: nil)
        }
        
        pan.setTranslation(CGPointZero, inView: pan.view)
    }
}
