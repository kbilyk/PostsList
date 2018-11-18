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
            Alamofire.request("https://jsonplaceholder.typicode.com/posts?userId=\(String(userIdentifier))").responseJSON(completionHandler: { (response) in
                print("Request: \(String(describing: response.request))")   // original url request
                print("Response: \(String(describing: response.response))") // http url response
                print("Result: \(response.result)")                         // response serialization result

                if let json = response.result.value {
                    print("JSON: \(json)") // serialized json response
                }

                if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                    print("Data: \(utf8Text)") // original server data as UTF8 string
                }
            })
        }
    }

    // MARK: - Configuration

    fileprivate func configure(_ cell: UITableViewCell, at indexPath: IndexPath) {
        guard let cell = cell as? PostTableViewCell else {
            return
        }

        print(cell)
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
