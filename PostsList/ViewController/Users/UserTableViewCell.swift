//
//  UserTableViewCell.swift
//  PostsList
//
//  Created by Kostiantyn Bilyk on 18.11.18.
//  Copyright © 2018 Kostiantyn Bilyk. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    // MARK: - Outlets

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    // MARK: - View Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
