//
//  JENHomeTableCell.swift
//  ONE_Swift
//
//  Created by 任玉祥 on 16/4/28.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

import UIKit
import SDWebImage

class JENHomeTableCell : UITableViewCell {
    
    
    @IBOutlet weak var hp_titleLabel: UILabel!
    
    @IBOutlet weak var hp_contentLabel: UILabel!
    
    @IBOutlet weak var hp_authorLabel: UILabel!
    
    @IBOutlet weak var hp_makeLabel: UILabel!
    
    @IBOutlet weak var hp_img_url: UIImageView!
   
    var homeSubTotal = JENHomeSubTotalItem() {
        
        didSet {
            hp_titleLabel.text = homeSubTotal.hp_title
            hp_contentLabel.text = homeSubTotal.hp_content
            hp_authorLabel.text = homeSubTotal.hp_author
            hp_makeLabel.text = homeSubTotal.hp_makettime
            
            guard let img_url = homeSubTotal.hp_img_url else {
                hp_img_url.image = UIImage(named: "home")
                return
            }
            hp_img_url.sd_setImageWithURL(NSURL(string: img_url), placeholderImage: UIImage(named: "home"))
        }
    }
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        selectionStyle = .None
//    }
    
}
