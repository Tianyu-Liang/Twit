//
//  ProfileViewController.swift
//  twitter_alamofire_demo
//
//  Created by Tianyu Liang on 3/26/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    @IBOutlet weak var profilePicture: UIImageView!
    
    @IBOutlet weak var tweetCount: UILabel!
    @IBOutlet weak var friendsCount: UILabel!
    @IBOutlet weak var followersCount: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: (User.current?.imageURL)!)
        profilePicture.af_setImage(withURL: url!)
        tweetCount.text = "tweets: \(User.current?.tweetCount ?? 0)"
        friendsCount.text = "following: \(User.current?.friends ?? 0)"
        followersCount.text = "followers: \(User.current?.followers ?? 0)"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
