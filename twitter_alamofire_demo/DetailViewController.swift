//
//  DetailViewController.swift
//  twitter_alamofire_demo
//
//  Created by Tianyu Liang on 3/22/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var profilePicture: UIImageView!
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var screenName: UILabel!
    
    @IBOutlet weak var tweetText: UILabel!
    
    @IBOutlet weak var retweetCount: UILabel!
    
    @IBOutlet weak var favoriteCount: UILabel!
    
    var tweet: Tweet!
    
    var delegate: ReplyViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        name.text = tweet.user.name
        screenName.text = tweet.user.screenName
        let url = URL(string: tweet.user.imageURL!)
        profilePicture.af_setImage(withURL: url!)
        tweetText.text = tweet.text
        retweetCount.text = "\(tweet.retweetCount)"
        favoriteCount.text = "\(tweet.favoriteCount)"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    func refreshData(){
        tweetText.text = tweet.text
        name.text = tweet.user.name
        screenName.text = "@\(tweet.user.screenName ?? "empty")"
        retweetCount.text = "\(tweet.retweetCount)"
        favoriteCount.text = "\(tweet.favoriteCount)"
        let url = URL(string: tweet.user.imageURL!)
        profilePicture.af_setImage(withURL: url!)
    }
    

    
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        let replyViewController = segue.destination as! ReplyViewController
        replyViewController.tweet = self.tweet
        replyViewController.delegate = delegate
                
    }
    

}
