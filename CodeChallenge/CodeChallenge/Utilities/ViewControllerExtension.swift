//
//  ViewControllerExtension.swift
//  CodeChallenge
//
//  Created by Mounika Jakkampudi on 10/11/20.
//  Copyright © 2020 MVVM. All rights reserved.
//

import UIKit
import MBProgressHUD

// UIViewController common functions
extension UIViewController {
    // Show loading indicator using MBProgressHUD
    func showProgressHUD(progressLabel: String) {
        DispatchQueue.main.async {
            let progressHUD = MBProgressHUD.showAdded(to: self.view, animated: true)
            progressHUD.label.text = progressLabel
        }
    }
    // Dismiss loading indicator using MBProgressHUD
    func dismissHUD(isAnimated: Bool) {
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: self.view, animated: isAnimated)
        }
    }
    // Show error alert on UIViewController with title and message
    func showErrorAlert(title: String, message: String) {
        DispatchQueue.main.async {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        }
    }
}
