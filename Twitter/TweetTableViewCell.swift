//
//  TweetTableViewCell.swift
//  Twitter
//
//  Created by Justin Schwartz on 7/23/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var tweetContent: UILabel!
    
    @IBOutlet weak var favButton: UIButton!
    
    
    @IBOutlet weak var retweetButton: UIButton!
    var favorited = false
    var tweetId: Int = -1
    var retweeted = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    
    
    func setFav(_ isFav: Bool) {
        favorited = isFav
        if favorited {
            retweetButton.setImage(UIImage(named: "favor-icon-red"), for: UIControl.State.normal)
        } else {
            retweetButton.setImage(UIImage(named: "favor-icon"), for: UIControl.State.normal)
        }
    }
    
    func setRetweeted(_ isRet: Bool) {
        retweeted = isRet
        if retweeted {
            favButton.setImage(UIImage(named: "retweet-icon-green"), for: UIControl.State.normal)
            favButton.isEnabled = false
        } else {
            favButton.setImage(UIImage(named: "retweet-icon"), for: UIControl.State.normal)
            favButton.isEnabled = true
        }
    }
    
    
    @IBAction func favorite(_ sender: Any) {
       let tobefav = !favorited
        if tobefav {
            TwitterAPICaller.client?.favoriteTweet(tweetId: tweetId, success: {
                self.setFav(true)
            }, failure: { error in
                print("favorite did not succeed \(error)")
            })
        } else {
            TwitterAPICaller.client?.unfavoriteTweet(tweetId: tweetId, success: {
                self.setFav(false)
            }, failure: { error in
                print("unfavorite did not succeed \(error)")
            })
        }
        
    }
    
    
    
    @IBAction func retweet(_ sender: Any) {
        TwitterAPICaller.client?.retweet(tweetId: tweetId, success: {
            self.setRetweeted(true)
        }, failure: { error in
            print("favorite did not succeed \(error)")
        })
        
    }
    
}
