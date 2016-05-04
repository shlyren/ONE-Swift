//
//  JENReadCarouselView.swift
//  ONE_Swift
//
//  Created by 任玉祥 on 16/4/30.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

import UIKit
import SDWebImage

class JENReadCarouselCell: UICollectionViewCell {

    private lazy var imageView : UIImageView = {
        return UIImageView(frame: self.bounds)
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class JENReadCarouselView: UIView {

    private let pageControlHeight : CGFloat = 30
    private let readCarouselCell = "JENReadCarouselCell"
    private let maxSectionNum = 10
    
    private var timer : NSTimer?
    
    private var readCarouseItems = [JENReadCarouselListItem]()
    
    private lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = self.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .Horizontal
        
        let collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.clearColor()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.pagingEnabled = true
        collectionView.scrollsToTop = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.registerClass(JENReadCarouselCell.classForCoder(), forCellWithReuseIdentifier: self.readCarouselCell)
        return collectionView
    }()

    private lazy var pageControl : UIPageControl = {
        let pageControl = UIPageControl(frame: CGRectMake(0, self.height - self.pageControlHeight, self.width, self.pageControlHeight))
        pageControl.currentPageIndicatorTintColor = JENDefaultColor
        pageControl.pageIndicatorTintColor = UIColor(white: 0.9, alpha: 1)
        pageControl.currentPage = 0
        self.addSubview(pageControl)
        return pageControl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.lightGrayColor()
        JENLoadData.loadReadCarouselList { (responseObject) in
            if responseObject.count > 0 {
                self.readCarouseItems = responseObject
                self.setupView()
            }
        }
    }
    
    private func setupView() {
        addSubview(collectionView)
        pageControl.numberOfPages = readCarouseItems.count
        collectionView.scrollToItemAtIndexPath(NSIndexPath(forItem: 0, inSection: self.maxSectionNum / 2), atScrollPosition: .Left, animated: false)
        collectionView.performBatchUpdates({
            self.collectionView.reloadSections(NSIndexSet(index: 0))
        }, completion: { (finished : Bool) in
            self.startTimer()
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        stopTimer()
        collectionView.delegate = nil
    }
}


// MARK: - pageChange
extension JENReadCarouselView {
    private func resPage() -> NSIndexPath {
        let currentIndexPath = collectionView.indexPathsForVisibleItems().last
        let currentIndexPathRes = NSIndexPath(forItem: (currentIndexPath?.item)!, inSection: maxSectionNum / 2)
        collectionView.scrollToItemAtIndexPath(currentIndexPathRes, atScrollPosition: .Left, animated: false)
        return currentIndexPathRes
    }
    
    @objc private func nextPage() {
        let currentPage = resPage()
        var nextItem = currentPage.item + 1
        var nextSection = currentPage.section
        if nextItem >= readCarouseItems.count {
            nextItem = 0
            nextSection += 1
        }
     
        let nextPagePath = NSIndexPath(forItem: nextItem, inSection: nextSection)
        collectionView.scrollToItemAtIndexPath(nextPagePath, atScrollPosition: .Left, animated: true)
    }
}


// MARK: - collectionView 协议
extension JENReadCarouselView : UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return maxSectionNum
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return readCarouseItems.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(readCarouselCell, forIndexPath: indexPath) as! JENReadCarouselCell
        let item = readCarouseItems[indexPath.row]
        
        if let cover = item.cover {
             cell.imageView.sd_setImageWithURL(NSURL(string: cover), placeholderImage: UIImage(named: "top10"))
        }
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {

        let readCarouseDetailVc = JENReadCarouseDetailViewController()
        let navigationController = JENNavigationController(rootViewController: readCarouseDetailVc)
        navigationController.delegate = self
        readCarouseDetailVc.readCarouseListItem = readCarouseItems[indexPath.item]
        window?.rootViewController?.presentViewController(navigationController, animated: true, completion: nil)
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let offsetX = collectionView.contentOffset.x
        let page = Int(offsetX / frame.size.width + 0.5) % (readCarouseItems.count)
        if pageControl.currentPage != page {
            pageControl.currentPage = page
        }
    }

    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        stopTimer()
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        startTimer()
    }
}

// MARK: - UINavigationControllerDelegate
extension JENReadCarouselView : UINavigationControllerDelegate {
    func navigationController(navigationController: UINavigationController, willShowViewController viewController: UIViewController, animated: Bool) {
        
        navigationController.setNavigationBarHidden(viewController.isKindOfClass(JENReadCarouseDetailViewController), animated: true)
    }
}

// MARK: - timer
extension JENReadCarouselView {
    func startTimer() {
        if readCarouseItems.count < 2 { return }
        timer = NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: #selector(JENReadCarouselView.nextPage), userInfo: nil, repeats: true)
    }
    
    func stopTimer() {
        if let timer = timer {
            timer.invalidate()
        }
        timer = nil
    }
}
