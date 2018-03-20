//
//  TweetCell.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/18/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage

class TweetCell: UITableViewCell {
    
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var screenName: UILabel!
    @IBOutlet weak var createdAt: UILabel!
    @IBOutlet weak var retweetCount: UILabel!
    @IBOutlet weak var favoriteCount: UILabel!
    @IBOutlet weak var imageURL: UIImageView!
    

    var tweet: Tweet! {
        didSet {
            tweetTextLabel.text = tweet.text
            name.text = tweet.user.name
            screenName.text = "@\(tweet.user.screenName ?? "empty")"
            createdAt.text = tweet.createdAtString
            retweetCount.text = "\(tweet.retweetCount)"
            favoriteCount.text = "\(tweet.favoriteCount)"
            let url = URL(string: tweet.user.imageURL!)
            imageURL.af_setImage(withURL: url!)
            
        
            
        }
    }
    @IBAction func retweet(_ sender: Any) {
        if(tweet.retweeted == true){
            tweet.retweeted = false
            tweet.retweetCount -= 1
            APIManager.shared.unretweet(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error unretweet tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully unretweet the following Tweet: \n\(tweet.text)")
                }
            }
        }else{
            tweet.retweeted = true
            tweet.retweetCount += 1
            APIManager.shared.retweet(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error retweeting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully retweeted the following Tweet: \n\(tweet.text)")
                }
            }
        }
        refreshData()
    }
    
    @IBAction func favorite(_ sender: Any) {
        if(tweet.favorited == true){
            tweet.favorited = false
            tweet.favoriteCount -= 1
            APIManager.shared.unfavorite(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error unfavoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully unfavorited the following Tweet: \n\(tweet.text)")
                }
            }
        }else{
            tweet.favorited = true
            tweet.favoriteCount += 1
            APIManager.shared.favorite(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error favoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully favorited the following Tweet: \n\(tweet.text)")
                }
            }
        }
        refreshData()
        
    }
    
    func refreshData(){
        tweetTextLabel.text = tweet.text
        name.text = tweet.user.name
        screenName.text = "@\(tweet.user.screenName ?? "empty")"
        createdAt.text = tweet.createdAtString
        retweetCount.text = "\(tweet.retweetCount)"
        favoriteCount.text = "\(tweet.favoriteCount)"
        let url = URL(string: tweet.user.imageURL!)
        imageURL.af_setImage(withURL: url!)
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
