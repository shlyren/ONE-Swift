//
//  JENMovieListCell.swift
//  ONE_Swift
//
//  Created by 任玉祥 on 16/5/10.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

import UIKit
import SDWebImage

class JENMovieListCell: UITableViewCell {

    var movieListItem = JENMovieListItem () {
        didSet {
            if let url = movieListItem.cover {
                coverImageView.sd_setImageWithURL(NSURL(string: url), placeholderImage: UIImage(named: "movieList_placeholder_\(arc4random_uniform(12))"))
            }
            contentView.addSubview(scoreView)
        }
    }
    
    private lazy var scoreView: JENMovieScoreView = {
       
        let frame = CGRectMake(JENScreenWidth - 81, JENScreenWidth * 0.45 - 50, 81, 50)
        let scoreView = JENMovieScoreView.scoreView(frame, score: self.movieListItem.score)
//
        return scoreView
    }()
    
    
    @IBOutlet private weak var coverImageView: UIImageView!
    
    override var frame: CGRect {
        
        set {
            var frame = newValue
            frame.size.height -= JENDefaultMargin
            super.frame = frame
        }
        
        get {return super.frame}
    }

    
}
