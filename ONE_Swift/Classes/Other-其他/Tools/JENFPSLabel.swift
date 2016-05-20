//
//  JENFPSLabel.swift
//  ONE_Swift
//
//  Created by 任玉祥 on 16/5/10.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

import UIKit

class JENFPSLabel: UILabel {
    
    var link = CADisplayLink()
    var count = 0
    var lastTime = NSTimeInterval()
    
    override init(frame: CGRect) {
        super.init(frame: CGRectMake(frame.origin.x, frame.origin.y, 65, 20))
        layer.cornerRadius = 5
        clipsToBounds = true
        textAlignment = .Center
        userInteractionEnabled = false
        backgroundColor = UIColor(white: 0, alpha: 0.7)
        textColor = UIColor.whiteColor()
        font = UIFont(name: "Menlo", size: 14)
        
        weak var weakSelf = self
        link = CADisplayLink(target: weakSelf!, selector: #selector(tick(_:)))
        link.addToRunLoop(NSRunLoop.mainRunLoop(), forMode: NSRunLoopCommonModes)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tick(link: CADisplayLink) {
        if lastTime == 0 {
            lastTime = link.timestamp
            return
        }
        count += 1
        let delta = link.timestamp - lastTime
        if delta < 1 {return}
        lastTime = link.timestamp
        let fps = Double(count) / delta
        count = 0
        
        let progress = CGFloat(fps) / 60.0
        textColor = UIColor(hue: 0.27 * (progress - 0.2), saturation: 1, brightness: 0.9, alpha: 1)
        text = NSString(format:"%.1fFPS", fps + 0.5) as String
    }
}
