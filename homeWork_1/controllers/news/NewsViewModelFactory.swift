//
//  NewsViewModelFactory.swift
//  homeWork_1
//
//  Created by Cayenne on 10.12.2022.
//  Copyright © 2022 Марат Нургалиев. All rights reserved.
//

import UIKit


class NewsViewModelFactory {
    
    private static let defaultImage = UIImage(named: "noPhoto")
    
    func constructViewModel(from feeds: [VkFeed]) -> [NewsViewModelFactory.ViewModel] {
        feeds.map{ ViewModel($0)}
    }
    
    
    
    struct ViewModel {
        
        private let feed: VkFeed
        var feedDate: String {
            feed.getFeedDate()
        }
        var sourceName: String {
            feed.sourceName
        }
        var feedHeight: CGFloat {
            feed.feedText.count == 0 ? 0 : 70
        }
        var text: String {
            feed.feedText
        }
        var likes: String {
            feed.getStringFrom(count: feed.countLikes)
        }
        var views: String {
            feed.getStringFrom(count: feed.countViews)
        }
        var shares: String {
            feed.getStringFrom(count: feed.countReposts)
        }
        var comments: String {
            feed.getStringFrom(count: feed.countComments)
        }
        var sourceUrl: URL? {
            URL(string: feed.sourceUrl)
        }
        var defaultImage: UIImage? {
            NewsViewModelFactory.defaultImage
        }
        var feedAttachment: FeedAttachment? {
            if feed.attachments.count > 0 {
                return FeedAttachment(size: CGFloat(feed.attachments[0].height) / CGFloat(feed.attachments[0].width),
                                      url: URL(string: feed.attachments[0].imageUrl))
            } else {
                return nil
            }
        }
        
        init(_ feed: VkFeed) {
            self.feed = feed
        }
        
        struct FeedAttachment {
            let size: CGFloat
            let url: URL?
        }
        
    }
    
}
