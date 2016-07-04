//
//  JENReadViewController.swift
//  ONE_Swift
//
//  Created by 任玉祥 on 16/4/27.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

import UIKit

class JENReadViewController: UIViewController {
    private var seletctedBtn = JENTitleButton()
    private let titlesView = UIView()
    private var titleLineView = UIView()
    private var scrollView = UIScrollView()
   
    private var readList = JENReadListItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        setupCarouseView()
        setupAllChildVc()
        
        JENLoadData.loadReadList { (resObj: JENReadListItem) in
            self.readList = resObj
            self.setupBaseView()
        }
    }

}


// MARK: - 初始化view
private extension JENReadViewController {
    // MARK: top轮播View
    func setupCarouseView() {
        let carouseView = JENReadCarouselView(frame: CGRect(x: 0, y: JENNavMaxY, width: JENScreenWidth, height: JENScreenWidth * 0.4))
        view.addSubview(carouseView)
    }
    // MARK: 添加所有子控制器
    private func setupAllChildVc() {
        addChildViewController(JENReadEssayViewController())
        addChildViewController(JENReadSerialViewController())
        addChildViewController(JENReadQuestionViewController())
    }
    // MARK: 初始化view
    private func setupBaseView() {
        let titles = ["短篇", "连载", "问答"]
        /// scrollView
        let scrollViewY = JENNavMaxY + JENScreenWidth * 0.4
        scrollView.frame = CGRect(x: 0, y: scrollViewY ,width: JENScreenWidth, height: JENScreenHeight - scrollViewY - JENTabBarH)
        scrollView.contentW = scrollView.width * CGFloat(titles.count)
        scrollView.isPagingEnabled = true
        scrollView.scrollsToTop = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
        view.addSubview(scrollView)
        
        /**
         *  titleView
         */
        titlesView.frame = CGRect(x: 0, y: scrollView.y, width: scrollView.width, height: JENTitleViewH)
        titlesView.backgroundColor = UIColor(white: 1, alpha: 0.9)
        
        /// titleBtn
        let titleBtnW = JENScreenWidth / CGFloat(titles.count)
        for i in 0 ..< titles.count {
            let frame = CGRect(x: CGFloat(i) * titleBtnW, y: 0, width: titleBtnW, height: titlesView.height)
            let titleBtn = JENTitleButton(frame: frame)
            titleBtn.tag = i
            titleBtn.setTitle(titles[i], for: UIControlState.application)
//            titleBtn.addTarget(self, action: #selector(titleBtnClick(_:)), forControlEvents: .TouchUpInside)
            titlesView.addSubview(titleBtn)
            titleBtn.addTarget(self, action: Selector.init(("titleBtnClick:")), for: UIControlEvents.touchUpInside)
            if i == 0 { titleBtnClick(btn: titleBtn) }
        }
        view.addSubview(titlesView)
        
        /// titleLine
        let titleLineH: CGFloat = 2
        let titleLineY = titlesView.height - titleLineH
        titleLineView.backgroundColor = seletctedBtn.titleColor(for: .selected)
        titleLineView.frame = CGRect(x: 0, y: titleLineY, width: 0, height: titleLineH);
        
        seletctedBtn.titleLabel!.sizeToFit()
        titleLineView.width = seletctedBtn.titleLabel!.width;
        titleLineView.centerX = seletctedBtn.width * 0.5;
        titlesView.addSubview(titleLineView)
    }

}

// MARK: - 事件处理
private extension JENReadViewController {
    // MARK: 标题按钮点击事件
    @objc private func titleBtnClick(btn: JENTitleButton) {
        if seletctedBtn == btn {return}
        seletctedBtn.isSelected = false
        btn.isSelected = true
        seletctedBtn = btn

        UIView.animate(withDuration: 0.2, animations: {
            self.titleLineView.centerX = btn.centerX;
            self.titleLineView.width = btn.titleLabel!.width;
            self.scrollView.offsetX = CGFloat(btn.tag) * self.scrollView.width
        }) { (finished: Bool) in
            let childVc  = self.childViewControllers[btn.tag] as! JENReadTableViewController;
            childVc.view.frame = self.scrollView.bounds
            self.scrollView.addSubview(childVc.view)
        }
        
        for i in 0 ..< self.childViewControllers.count {
            let childVc = self.childViewControllers[i] as! JENReadTableViewController;
            childVc.readList = readList
            guard childVc.isViewLoaded() else { continue }
            childVc.tableView.scrollsToTop = i == btn.tag
        }
        
    }
}

// MARK: -  UIScrollViewDelegate
extension JENReadViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = Int(scrollView.offsetX / scrollView.width)
        titleBtnClick(btn: titlesView.subviews[index] as! JENTitleButton)
    }
}
