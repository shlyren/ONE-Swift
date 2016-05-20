//
//  JENMovieHeaderView.swift
//  ONE_Swift
//
//  Created by 任玉祥 on 16/5/11.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

import UIKit
import SDWebImage


typealias JENMovieHeaderViewContentChangeBlock = (height: CGFloat) -> ()
class JENMovieHeaderView: UIView {

    var detail_id = "" {
        didSet {
            loadData(detail_id)
        }
    }
    
    
    func contentChange(contenChangeBlock: JENMovieHeaderViewContentChangeBlock) {
        self.contentChangeBlock = contenChangeBlock
    }
    
    private var contentChangeBlock: JENMovieHeaderViewContentChangeBlock?
    
    deinit {
        print("JENMovieHeaderView == deinit")
    }
    
    private var storyRes = JENMovieStroyResult() {
        didSet {
            self.storyCountLabel.text = "共\(storyRes.count)个电影故事"
            let storyItem = storyRes.data[0]
//            if  storyRes.data[0] as JENMovieStoryItem {
            
                self.storyLabel.attributedText = NSMutableAttributedString.attributedStringWithString(storyItem.content)
                self.storyLabel.sizeToFit()
                self.storyViewHeight.constant += self.storyLabel.height
                if let contentChangeBlock = self.contentChangeBlock {
                    contentChangeBlock(height: self.storyLabel.height)
                }
//            }
//
        }
    }
    
    
    private var detailItem = JENMovieDetailItem() {
        didSet {
            guard let coverUrl = detailItem.detailcover else { return }
            self.detailCoverImageView.sd_setImageWithURL(NSURL(string: coverUrl), placeholderImage: UIImage(named: "movie"))
        }
    }
    
    class func headerView(detail_id: String) -> JENMovieHeaderView {
        let headerView =  NSBundle.mainBundle().loadNibNamed("JENMovieHeaderView", owner: nil, options: nil).first as! JENMovieHeaderView
        headerView.detail_id = detail_id
        return headerView
    }
    
    @IBOutlet private weak var detailCoverImageView: UIImageView!
    
    @IBOutlet private weak var storyCountLabel: UILabel!
    
    @IBOutlet private weak var storyView: UIView!
    
    @IBOutlet private weak var storyViewHeight: NSLayoutConstraint!
    
    private lazy var movieStoryView: JENMovieHeaderView = {
       let movieStoryView = NSBundle.mainBundle().loadNibNamed("JENMovieHeaderView", owner: nil, options: nil)[1] as! JENMovieHeaderView
//            movieStoryView.frame = self.
//        movieStoryView.storyLabel.preferredMaxLayoutWidth = JENScreenWidth - 60
        return movieStoryView
    }()
    
    
    @IBOutlet weak var storyLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

}


private extension JENMovieHeaderView {
    func loadData(detail_id: String) {
        
        JENLoadData.loadMovieDetail(detail_id) { (resObj) in
            self.detailItem = resObj
        }
        
        JENLoadData.loadMovieStory(detail_id) { (resObj) in
            self.storyView.addSubview(self.movieStoryView)
            self.storyRes = resObj
            

        }
    }
}