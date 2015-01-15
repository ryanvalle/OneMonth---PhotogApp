//
//  PostCell.swift
//  photog
//
//  Created by Ryan Valle on 12/16/14.
//  Copyright (c) 2014 RyanValle.me. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {

    @IBOutlet var postImageView: UIImageView?
    @IBOutlet var usernameLabel: UILabel?
    @IBOutlet var dateLabel: UILabel?
    
    var post: PFObject? {
        didSet {
            self.configure()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

        self.contentView.backgroundColor = UIColor.OMLightGray()
        
        self.postImageView?.image = UIImage(named: "PostPlaceholderImage")
        self.usernameLabel?.text = nil
    }

    override func prepareForReuse() {
        super.awakeFromNib()

        self.dateLabel?.text = nil
        self.post = nil
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure() {
        
        self.postImageView!.clipsToBounds = true
        // check if there's a post object
        if let constPost = post {
            // set username label
            var user = constPost["User"] as PFUser
            user.fetchInBackgroundWithBlock({
                (object, error) -> Void in
                if let constObject = object {
                    self.usernameLabel!.text = user.username
                } else if let constError = error {
                    self.usernameLabel!.text = "No User"
                }
            })

            // set date label
            var date = constPost.createdAt
            self.dateLabel?.text = date.fuzzyTime()

            // download the image and display it
            NetworkManager.sharedInstance.fetchImage(constPost, completionHandler: {
                (image, error) -> () in
                
                if image != nil {
                    self.postImageView!.image = image
                } else {
                    self.postImageView!.image = UIImage(named: "PostPlaceholderImage")
                }
                
            })
        }
    }
    
}
