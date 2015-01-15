//
//  NetworkManager.swift
//  photog
//
//  Created by Ryan Valle on 12/16/14.
//  Copyright (c) 2014 RyanValle.me. All rights reserved.
//

import Foundation

typealias ObjectCompetionHandler = (objects: [AnyObject]?, error: NSError?) -> ()
typealias ImageCompletionHandler = (image: UIImage?, error: NSError?) -> ()

public class NetworkManager {
    public class var sharedInstance: NetworkManager {
        struct Singleton {
            static let instance = NetworkManager()
        }
        return Singleton.instance
    }
    
    func follow(user: PFUser!, completionHandler:(error: NSError?) -> ()) {
        var relation = PFUser.currentUser().relationForKey("following")
        relation.addObject(user)
        PFUser.currentUser().saveInBackgroundWithBlock{
            (success, error) -> Void in
            completionHandler(error: error)
        }
    }
    
    func fetchFeed(completionHandler: ObjectCompetionHandler!) {
        var relation = PFUser.currentUser().relationForKey("following")
        var query = relation.query()
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            
            if (error != nil)
            {
                println("error fetching following")
                completionHandler(objects: nil, error: error)
            }
            else
            {
                var postQuery = PFQuery(className: "Post")
                postQuery.whereKey("User", containedIn: objects)
                postQuery.orderByDescending("createdAt")
                postQuery.findObjectsInBackgroundWithBlock {
                    (objects: [AnyObject]!, error: NSError!) -> Void in
                    if (error != nil)
                    {
                        println("error fetching feed posts)")
                        completionHandler(objects: nil, error: error)
                    }
                    else
                    {
                        completionHandler(objects: objects, error: nil)
                    }
                }
                
            }
        }
    }
    
    func fetchImage(post: PFObject!, completionHandler: ImageCompletionHandler!) {
        var imageReference = post["image"] as PFFile
        imageReference.getDataInBackgroundWithBlock {
            (data, error) -> () in
            
            if (error != nil) {
                println("Error fetching image \(error.localizedDescription)")
                completionHandler(image: nil, error: error)
            } else {
                let image = UIImage(data: data)
                completionHandler(image:image, error: nil)
            }
        }
    }
    
    func findUsers(searchTerm: String!, completionHandler: ObjectCompetionHandler!) {
        var query = PFUser.query()
        query.whereKey("username", containsString: searchTerm)
        
        var descriptor = NSSortDescriptor(key: "username", ascending: false)
        query.orderBySortDescriptor(descriptor)
        
        query.findObjectsInBackgroundWithBlock {
            (objects, error) -> Void in

            if (error != nil) {
                println("Error searching for users")
                completionHandler(objects: nil, error: error)
            } else {
                println("Success searching for users")
                completionHandler(objects: objects, error: nil)
            }
        }
    }
}