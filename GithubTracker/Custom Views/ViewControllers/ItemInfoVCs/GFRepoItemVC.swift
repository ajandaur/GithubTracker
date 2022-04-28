//
//  GFRepoItemVC.swift
//  GithubTracker
//
//  Created by Anmol  Jandaur on 4/27/22.
//

import Foundation

class GFRepoItemVC: GFItemInfoVC {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
        
    }
    
    private func configureItems() {
        // want to specify itemInfoView to repo
        itemInfoViewOne.set(itemInfoType: .repos, withCount: user.publicRepos)
        itemInfoViewTwo.set(itemInfoType: .gists, withCount: user.publicGists)
        actionButton.set(backgroundColor: .systemPurple, title: "GitHub Profile")
    }
    
    override func actionButtonTapped() {
        delegate.didTapGitHubProfile(for: user)
    }
}
