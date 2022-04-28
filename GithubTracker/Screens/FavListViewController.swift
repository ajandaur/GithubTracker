//
//  FavListViewController.swift
//  GithubTracker
//
//  Created by Anmol  Jandaur on 4/17/22.
//

import UIKit

class FavListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // try to retrieve fav followers array
        PersistenceManager.retrieveFavorites { result in
            switch result {
            case .success(let favorites):
                print(favorites)
            case .failure(let error):
                break
            }
        }
    }
    
}
