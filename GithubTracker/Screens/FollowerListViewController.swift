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
    var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureCollectionView()
        getFollowers()
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureCollectionView() {
        // initialize collectionView
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UICollectionViewFlowLayout())
        
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemRed
        // register the cell
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
    }
    
    func getFollowers() {
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
    
}
