//
//  FollowerListViewController.swift
//  GithubTracker
//
//  Created by Anmol  Jandaur on 4/18/22.
//

import UIKit

class FollowerListViewController: UIViewController {
    // Want to pass in a username to get the list of followers via network call
    var username: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // introduce completion handler via singleton
        NetworkManager.shared.getFollower(for: username, page: 1) { result in
            
            switch result {
                // if successful..
            case .success(let followers):
                // configure collectionView
                print(followers)
                
                // if fails..
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Bad Stuff Happened", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
}
