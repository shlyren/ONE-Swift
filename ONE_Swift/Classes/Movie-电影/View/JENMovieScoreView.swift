//
//  JENMovieScoreView.swift
//  ONE_Swift
//
//  Created by 任玉祥 on 16/5/11.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

import UIKit

class JENMovieScoreView: UIView {

    class func scoreView(frame: CGRect, score: String?) -> JENMovieScoreView {
      
        let scoreView = NSBundle.mainBundle().loadNibNamed("JENMovieScoreView", owner: nil, options: nil).first as! JENMovieScoreView
       
        scoreView.frame = frame
        scoreView.y -= JENDefaultMargin * 3
        scoreView.x -= JENDefaultMargin * 2
        scoreView.scoreLabel.text = score
        scoreView.transform = CGAffineTransformMakeRotation(CGFloat(-M_PI_4) * 0.2)
        
        return scoreView
    }

    
    @IBOutlet private weak var scoreLabel: UILabel!
   

}
