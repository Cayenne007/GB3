//
//  NewsViewController.swift
//  homeWork_1
//
//  Created by User on 30.09.2018.
//  Copyright © 2018 User. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    private let refreshControl = UIRefreshControl()
    
//    private let exampleCell = NewsTableViewCell()
    private var textHeight: CGFloat = 0
    private var imageHeight: CGFloat = 0
    
    
    private var feeds = [VkFeed]()
    
    private var needClearNews = true
    private var isLoad = false
    private let dataServiceAdapter = DataServiceAdapter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableViewSettings()
        prepareGetFeeds(needClearNews: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
        
    }
    
    private func prepareGetFeeds(needClearNews: Bool) {
        isLoad = true
        self.needClearNews = needClearNews
        
        dataServiceAdapter.getNews(needClearNews: needClearNews) { [weak self] feeds in
            self?.refreshControl.endRefreshing()
            self?.isLoad = false
            if let _ = self?.needClearNews {
                self?.feeds.removeAll()
                self?.tableView.reloadData()
            }
            self?.feeds.append(contentsOf: feeds)
            self?.tableView.reloadData()
        }
    }
    
    
    private func setTableViewSettings() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
        refreshControl.addTarget(self, action: #selector(refreshNews(_:)), for: .valueChanged)
    }
    
    
    @objc private func refreshNews(_ sender: Any) {
        prepareGetFeeds(needClearNews: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showFeedInfo" {
            let upcoming = segue.destination as! NewsInfoViewController
            upcoming.feed = feeds[sender as! Int]
        }
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
    }

}

extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feeds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell", for: indexPath) as! NewsTableViewCell
        cell.configure(feed: feeds[indexPath.row])
        cell.delegate = self
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "showFeedInfo", sender: indexPath.row)
    }
    
    
    open func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == feeds.count - 2 && !isLoad {
            
            prepareGetFeeds(needClearNews: false)
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        textHeight = feeds[indexPath.row].feedText.count > 0 ? 70 : 0
        imageHeight = feeds[indexPath.row].attachments.count > 0 ? self.view.frame.width * CGFloat(feeds[indexPath.row].attachments[0].height) / CGFloat(feeds[indexPath.row].attachments[0].width) : 0
        let height = CGFloat(10 + 10 + 60 + imageHeight + textHeight + 40 + 10)
        
        return height
    }

}

extension NewsViewController: NewsTableViewCellDelegate {
    func changeLike(row: Int) {
//        news[row].changeLike()
    }
    
}

extension NewsViewController {
    
    private func addNewCells(array: [VkFeed]) {
        if (array.count > 0) {
            tableView.beginUpdates()
            var indexPaths = [NSIndexPath]()
            for row in (feeds.count..<(feeds.count + array.count)) {
                indexPaths.append(NSIndexPath(row: row, section: 0))
            }
            feeds.append(contentsOf: array)
            
            tableView.insertRows(at: indexPaths as [IndexPath], with: .automatic)
            tableView.endUpdates()
        }
    }
    
}




