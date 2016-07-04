//
//  JENMovieListViewController.swift
//  ONE_Swift
//
//  Created by 任玉祥 on 16/4/27.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

import UIKit

class JENMovieListViewController: UITableViewController {

    private let moviListCellID = "JENMovieListCell"
    
    private var movieListItems = [JENMovieListItem]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

}
// MARK: - view
private extension JENMovieListViewController {
    func setupView() {
        tableView.registerNib(UINib.init(nibName: moviListCellID, bundle: nil), forCellReuseIdentifier: moviListCellID)
        tableView.separatorStyle = .None
        tableView.backgroundColor = UIColor(white: 0.9, alpha: 1)
        tableView.mj_header = JENRefreshHeader(refreshingTarget: self, refreshingAction: #selector(loadData))
        tableView.mj_footer = JENRefreshFooter(refreshingTarget: self, refreshingAction: #selector(loadMoreData))
        tableView.mj_header.beginRefreshing()
    }
}

// MARK: - data
private extension JENMovieListViewController {
    @objc func loadData() {
        JENLoadData.loadMovieList("0") { (resObj) in
            if resObj.count > 0 {
                self.movieListItems = resObj
            }
            self.tableView.mj_header.endRefreshing()
            self.tableView.mj_footer.resetNoMoreData()
        }
    }
    
    @objc func loadMoreData() {
        
        guard movieListItems.count > 0 else { return }
        
        guard let movie_id = movieListItems.last?.detail_id else {return}
        JENLoadData.loadMovieList(movie_id) { (resObj) in
            if resObj.count > 0 {
                self.movieListItems += resObj
            }
            if resObj.count < 20 {
                self.tableView.mj_footer.endRefreshingWithNoMoreData()
            }else {
                self.tableView.mj_footer.endRefreshing()
            }
        }
    }
}

// MARK: - table View Protocol
extension JENMovieListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieListItems.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: moviListCellID) as! JENMovieListCell
        cell.movieListItem = movieListItems[indexPath.row]
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return JENScreenWidth * 0.45
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let detailVc = JENMovieDetailViewController()
        detailVc.title = movieListItems[indexPath.row].title
        guard let detail_id = movieListItems[indexPath.row].detail_id else { return }
        detailVc.detail_id = detail_id
        navigationController?.pushViewController(detailVc, animated: true)
    }
}
