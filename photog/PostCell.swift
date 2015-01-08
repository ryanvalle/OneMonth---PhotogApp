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
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure() {
        // check if there's a post object
        if let constPost = post {
            // set username label
            var user = constPost["User"] as PFUser
            user.fetchInBackgroundWithBlock({
                (object, error) -> Void in
                if let constObject = object {
                    self.usernameLabel!.text = user.username
                } else if let constError = error {
                    //alert the user
                }
            })

            // set date label
            var date = constPost.createdAt
            self.dateLabel?.text = date.fuzzyTime()
            // download the image and display it
        }
    }
    
}
