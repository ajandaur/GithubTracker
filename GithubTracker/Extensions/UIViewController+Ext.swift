//
//  UIViewController+Ext.swift
//  GithubTracker
//
//  Created by Anmol  Jandaur on 4/18/22.
//

import UIKit
import SafariServices

extension UIViewController {
    
    func presentGFAlert(title: String, message: String, buttonTitle: String) {
        // create alertVC
        let alertVC = GFAlertVC(title: title, message: message, buttonTitle: buttonTitle)
        // configure alert to cover the screen
        alertVC.modalPresentationStyle = .overFullScreen
        // enable animation for fading in
        alertVC.modalTransitionStyle = .crossDissolve
        present(alertVC, animated: true)
    }
    
    func presentDefaultError() {
        // create alertVC
        let alertVC = GFAlertVC(title: "Something went wrong", message: "We were unable to complete your task at this time, Please try again.", buttonTitle: "Ok")
        // configure alert to cover the screen
        alertVC.modalPresentationStyle = .overFullScreen
        // enable animation for fading in
        alertVC.modalTransitionStyle = .crossDissolve
        present(alertVC, animated: true)
    }
    
    func presentSafariVC(with url: URL) {
        
        // Present Safari VC
        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = .systemGreen
        present(safariVC, animated: true)
    }
    
    
    
}
