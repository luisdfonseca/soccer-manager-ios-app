//
//  ViewController.swift
//  Soccer-App
//
//  Created by luis daniel fonseca on 11/26/16.
//  Copyright © 2016 luis daniel fonseca. All rights reserved.
//

import UIKit

class UserViewController: UIViewController, UITableViewDataSource, UITabBarDelegate {

    @IBOutlet weak var tableview: UITableView!
    
    var movies = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        movies.append("Test")
        movies.append("Test2")
        print(movies[1])
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableview.dequeueReusableCellWithIdentifier("UITableViewCell", forIndexPath: indexPath)
        
        let movie = movies[indexPath.row]
        print(movie)
        cell.textLabel?.text = movie
        
        return cell
    }

   
}

