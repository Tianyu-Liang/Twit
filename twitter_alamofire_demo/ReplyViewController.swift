//
//  ComposeViewController.swift
//  twitter_alamofire_demo
//
//  Created by Tianyu Liang on 3/25/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

protocol ReplyViewControllerDelegate {
    func ref(post: Tweet)
}

class ReplyViewController: UIViewController, UITextViewDelegate {
    
    var delegate: ReplyViewControllerDelegate?
    
    
    @IBOutlet weak var textView: UITextView!
    
    
    var tweet: Tweet!
    

    @IBAction func reply(_ sender: Any) {
        APIManager.shared.reply(tweet, with: textView.text) { (tweet, error) in
            if let error = error {
                print("Error replying Tweet: \(error.localizedDescription)")
            } else if let tweet = tweet {
                self.delegate?.ref(post: tweet)
                print("reply Tweet Success!")
            }
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        textView.delegate = self
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        // TODO: Check the proposed new text character count
        // Allow or disallow the new text
        // Set the max character limit
        let characterLimit = 140
        
        // Construct what the new text would be if we allowed the user's latest edit
        let newText = NSString(string: textView.text!).replacingCharacters(in: range, with: text)
        
        // TODO: Update Character Count Label
        
        // The new text should be allowed? True/False
        return newText.characters.count < characterLimit
        
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

