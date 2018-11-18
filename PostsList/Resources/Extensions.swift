//
//  Extensions.swift
//  PostsList
//
//  Created by Kostiantyn Bilyk on 18.11.18.
//  Copyright © 2018 Kostiantyn Bilyk. All rights reserved.
//

import Foundation
import UIKit

extension UITableViewCell {
    public class var cellIdentifier: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
}
