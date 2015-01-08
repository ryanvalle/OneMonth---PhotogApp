//
//  FeedViewController.swift
//  photog
//
//  Created by Ryan Valle on 12/16/14.
//  Copyright (c) 2014 RyanValle.me. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController,UITableViewDataSource {

    @IBOutlet var tableView: UITableView?
    
    var items = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var nib = UINib(nibName: "PostCell", bundle: nil)
        tableView?.registerNib(nib, forCellReuseIdentifier: "PostCellController")
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        NetworkManager.sharedInstance.fetchFeed {
            (objects, error) -> () in
            println(objects)
            if let constObjects = objects {
                self.items = constObjects
                self.tableView?.reloadData()
            } else if let constError = error {
                // alert user of error
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PostCellController") as PostCell
        
        var item = items[indexPath.row] as PFObject
        cell.post = item
        
        return cell
    }
}
