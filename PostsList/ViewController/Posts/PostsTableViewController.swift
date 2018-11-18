//
//  PostsTableViewController.swift
//  PostsList
//
//  Created by Kostiantyn Bilyk on 18.11.18.
//  Copyright © 2018 Kostiantyn Bilyk. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class PostsTableViewController: UITableViewController {

    // MARK: - Variables

    var userIdentifier: Int?
    var posts: Array<Dictionary<String, Any>>? = []

    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let userIdentifier = userIdentifier {
            // Reqest
            showHUD(animated: true)
            Alamofire.request("https://jsonplaceholder.typicode.com/posts?userId=\(String(userIdentifier))").responseJSON { (response) in
                // Serialization
                if let postJSONsArray = JSON(response.result.value as Any).array {
                    for postJSON in postJSONsArray {
                        var post: Dictionary <String, Any> = [:]

                        if let identifier = postJSON[JSONKeys.identifier].int {
                            post[JSONKeys.identifier] = identifier
                        }
                        if let title = postJSON[JSONKeys.title].string {
                            post[JSONKeys.title] = title
                        }
                        if let body = postJSON[JSONKeys.body].string {
                            post[JSONKeys.body] = body
                        }

                        self.posts?.append(post)
                    }
                }

                self.hideHUD(animated: true)
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Configuration

    fileprivate func configure(_ cell: UITableViewCell, at indexPath: IndexPath) {
        guard let cell = cell as? PostTableViewCell else {
            return
        }

        guard let posts = posts else {
            return
        }

        if !posts.indices.contains(indexPath.row) {
            return
        }

        let post = posts[indexPath.row]

        cell.titleLabel.text = post[JSONKeys.title] as! String?
        cell.bodyLabel.text = post[JSONKeys.body] as! String?
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let posts = posts else {
            return 0
        }

        return posts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.cellIdentifier, for: indexPath)

        configure(cell, at: indexPath)

        return cell
    }
}
