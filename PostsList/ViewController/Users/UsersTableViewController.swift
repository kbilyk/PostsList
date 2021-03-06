//
//  UsersTableViewController.swift
//  PostsList
//
//  Created by Kostiantyn Bilyk on 18.11.18.
//  Copyright © 2018 Kostiantyn Bilyk. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class UsersTableViewController: UITableViewController {

    // MARK: - Variables

    var users: Array<Dictionary<String, Any>>? = []

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Reqest
        showHUD(animated: true)
        Alamofire.request("https://jsonplaceholder.typicode.com/users").responseJSON { (response) in
            // Serialization
            if let usersArray = JSON(response.result.value as Any).array {
                for userJSON in usersArray {
                    var user: Dictionary <String, Any> = [:]

                    if let identifier = userJSON[JSONKeys.identifier].int {
                        user[JSONKeys.identifier] = identifier
                    }
                    if let name = userJSON[JSONKeys.name].string {
                        user[JSONKeys.name] = name
                    }
                    if let username = userJSON[JSONKeys.username].string {
                        user[JSONKeys.username] = username
                    }
                    if let email = userJSON[JSONKeys.email].string {
                        user[JSONKeys.email] = email
                    }
                    if let addressDictionary = userJSON[JSONKeys.address].dictionary {
                        var address: Dictionary <String, String> = [:]

                        if let street = addressDictionary[JSONKeys.street]?.string {
                            address[JSONKeys.street] = street
                        }
                        if let suit = addressDictionary[JSONKeys.suit]?.string {
                            address[JSONKeys.suit] = suit
                        }
                        if let city = addressDictionary[JSONKeys.city]?.string {
                            address[JSONKeys.city] = city
                        }
                        if let zipcode = addressDictionary[JSONKeys.zipcode]?.string {
                            address[JSONKeys.zipcode] = zipcode
                        }
                        user[JSONKeys.address] = address
                    }
                    self.users?.append(user)
                }
            }

            self.hideHUD(animated: true)
            self.tableView.reloadData()
        }
    }

    // MARK: - Configuration

    fileprivate func configure(_ cell: UITableViewCell, at indexPath: IndexPath) {
        guard let cell = cell as? UserTableViewCell else {
            return
        }

        guard let users = users else {
            return
        }

        if !users.indices.contains(indexPath.row) {
            return
        }

        let user = users[indexPath.row]

        cell.nameLabel.text = user[JSONKeys.name] as! String?
        cell.usernameLabel.text = user[JSONKeys.username] as! String?
        cell.emailLabel.text = user[JSONKeys.email] as! String?
        if let address = user[JSONKeys.address] as? Dictionary<String, String> {
            var addressLabelText = address[JSONKeys.street] ?? ""

            if let suit = address[JSONKeys.suit] {
                addressLabelText.append(addressLabelText.isEmpty ? suit : ", \(suit)")
            }
            if let city = address[JSONKeys.city] {
                addressLabelText.append(addressLabelText.isEmpty ? city : ", \(city)")
            }
            if let zipcode = address[JSONKeys.zipcode] {
                addressLabelText.append(addressLabelText.isEmpty ? zipcode : ", \(zipcode)")
            }

            cell.addressLabel.text = addressLabelText
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let users = users else {
            return 0
        }

        return users.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.cellIdentifier, for: indexPath)

        configure(cell, at: indexPath)

        return cell
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier, identifier == SegueIdentifiers.usersToPosts {
            if let users = users {
                if let indexPath = tableView.indexPathForSelectedRow {
                    if let postsViewController = segue.destination as? PostsTableViewController {
                        postsViewController.userIdentifier = users[indexPath.row][JSONKeys.identifier] as? Int
                    }
                }
            }
        }
    }
}
