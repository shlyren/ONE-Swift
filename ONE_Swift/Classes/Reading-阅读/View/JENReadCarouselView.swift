
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

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame: self.bounds)
        imageView.image = UIImage(named: "top10")
        return imageView
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

    private let pageControlHeight: CGFloat = 30
    private let readCarouselCell = "JENReadCarouselCell"
    private let maxSectionNum = 10
    
    private var timer: Timer?
    private var readCarouseItems = [JENReadCarouselListItem]()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = self.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.clear()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isPagingEnabled = true
        collectionView.scrollsToTop = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(JENReadCarouselCell.classForCoder(), forCellWithReuseIdentifier: self.readCarouselCell)
        return collectionView
    }()

    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl(frame: CGRect(x: 0, y: self.height - self.pageControlHeight, width: self.width, height: self.pageControlHeight));
        pageControl.currentPageIndicatorTintColor = JENDefaultColor
        pageControl.pageIndicatorTintColor = UIColor(white: 0.9, alpha: 1)
        pageControl.currentPage = 0
        self.addSubview(pageControl)
        return pageControl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.lightGray()
        JENLoadData.loadReadCarouselList { (resObj) in
            if resObj.count > 0 {
                self.readCarouseItems = resObj
                self.setupView()
            }
        }
    }
    
    private func setupView() {
        addSubview(collectionView)
        pageControl.numberOfPages = readCarouseItems.count
        
        collectionView.scrollToItemAtIndexPath(NSIndexPath(forItem: 0, inSection: self.maxSectionNum / 2), atScrollPosition: .Left, animated: false)
        
        collectionView.performBatchUpdates({
            self.collectionView.reloadSections(IndexSet(integer: 0));
        }, completion: { (finished: Bool) in
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
private extension JENReadCarouselView {
    func resPage() -> NSIndexPath {
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


// MARK: - collectionView protocol
extension JENReadCarouselView: UICollectionViewDataSource, UICollectionViewDelegate {
    
    private func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return maxSectionNum
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return readCarouseItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: readCarouselCell, for: indexPath) as! JENReadCarouselCell
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
        window?.rootViewController?.present(navigationController, animated: true, completion: nil)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetX = collectionView.contentOffset.x
        let page = Int(offsetX / frame.size.width + 0.5) % (readCarouseItems.count)
        if pageControl.currentPage != page {
            pageControl.currentPage = page
        }
    }

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        stopTimer()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        startTimer()
    }
}

// MARK: - UINavigationControllerDelegate
extension JENReadCarouselView: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        
        navigationController.setNavigationBarHidden(viewController.isKind(of: JENReadCarouseDetailViewController.classForCoder()), animated: true)
    }
}

// MARK: - timer
private extension JENReadCarouselView {
    func startTimer() {
        if readCarouseItems.count < 2 { return }
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(nextPage), userInfo: nil, repeats: true)
    }
    
    func stopTimer() {
        if let timer = timer {
            timer.invalidate()
        }
        timer = nil
    }
}
