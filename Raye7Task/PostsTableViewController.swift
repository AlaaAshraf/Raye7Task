//
//  PostsTableViewController.swift
//  Raye7Task
//
//  Created by Alaa Ashraf on 6/20/17.
//  Copyright © 2017 Alaa Ashraf. All rights reserved.
//

import UIKit


class PostsTableViewController: UITableViewController {
   
    var myPosts: [[String: Any]] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        getPosts()
        //print(myPosts.count)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        //return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return the number of rows
        print(myPosts.count)
        return myPosts.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = self.myPosts[indexPath.row]["title"] as! String
        cell.detailTextLabel?.text = self.myPosts[indexPath.row]["body"] as! String
        return cell
    }
    
    func getPosts() {
        
        let postsEndpoint: String = "https://jsonplaceholder.typicode.com/posts"
        guard let url = URL(string: postsEndpoint) else {
            print("Error: cannot create URL")
            return
        }
        let urlRequest = URLRequest(url: url)
        let session = URLSession.shared
        
        let task = session.dataTask(with: urlRequest){
            (data, response, error) in
            //check for errors
            guard error == nil else {
                print("error calling GET")
                print(error!)
                return
            }
            //check for data receival
            guard let responseData = data else{
                print("Error: No data Received")
                return
            }
            //parse the result as JSON
            do {
                guard let posts = try JSONSerialization.jsonObject(with: responseData, options: []) as? [[String: Any]] else{
                    print("Error in JSON conversion")
                    return
                }
                self.myPosts = posts
                self.tableView.reloadData()
                //print(self.myPosts.count)
            }
            catch{
                print("error trying to convert data to JSON")
                return
            }
        }
        
        task.resume()
        
    }
    

    

}
