//
//  SearchViewController.swift
//  photog
//
//  Created by Ryan Valle on 1/12/15.
//  Copyright (c) 2015 RyanValle.me. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet var searchBar: UISearchBar?
    @IBOutlet var tableView: UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
        // clear search bar on open
        searchBar.text = ""
    }
    
    // go to exit mode
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    // do something in exit mode
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
    }

    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        var searchTerm = searchBar.text
        NetworkManager.sharedInstance.findUsers(searchTerm, completionHandler: {(objects,error) -> () in
            println(objects)
            println(error)
        })
        
    }
    
}
