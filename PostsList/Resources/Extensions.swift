//
//  Extensions.swift
//  PostsList
//
//  Created by Kostiantyn Bilyk on 18.11.18.
//  Copyright © 2018 Kostiantyn Bilyk. All rights reserved.
//

import Foundation
import UIKit
import MBProgressHUD

extension UITableViewCell {
    public class var cellIdentifier: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
}

extension UIViewController {
    func showHUD(animated:Bool){
        MBProgressHUD.showAdded(to: self.view, animated: animated)
    }

    func hideHUD(animated:Bool) {
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: self.view, animated: animated)
        }
    }
}
