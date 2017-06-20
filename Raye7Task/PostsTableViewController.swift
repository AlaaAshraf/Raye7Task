//
//  PostsTableViewController.swift
//  Raye7Task
//
//  Created by Alaa Ashraf on 6/20/17.
//  Copyright © 2017 Alaa Ashraf. All rights reserved.
//

import UIKit


class PostsTableViewController: UITableViewController {
   
    var posts: [[String: Any]] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        getPosts()
        
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        //return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return the number of rows
        print(posts.count)
        return posts.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = self.posts[indexPath.row]["title"] as! String
        cell.detailTextLabel?.text = self.posts[indexPath.row]["body"] as! String
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
                self.posts = posts
                self.tableView.reloadData()
                //print(self.posts.count)
            }
            catch{
                print("error trying to convert data to JSON")
                return
            }
        }
        
        task.resume()
        
    }
    

    

}
