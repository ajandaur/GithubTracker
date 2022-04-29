//
//  UIViewController+Ext.swift
//  GithubTracker
//
//  Created by Anmol  Jandaur on 4/18/22.
//

import UIKit
import SafariServices



extension UIViewController {
    
    
    func presentGFAlertOnMainThread(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            // create alertVC
            let alertVC = GFAlertVC(title: title, message: message, buttonTitle: buttonTitle)
            // configure alert to cover the screen
            alertVC.modalPresentationStyle = .overFullScreen
            // enable animation for fading in
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
    
    func presentSafariVC(with url: URL) {
        
        // Present Safari VC
        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = .systemGreen
        present(safariVC, animated: true)
    }
    
    

}
