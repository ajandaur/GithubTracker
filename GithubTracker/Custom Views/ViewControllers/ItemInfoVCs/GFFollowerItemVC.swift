//
//  GFFollowerItemVC.swift
//  GithubTracker
//
//  Created by Anmol  Jandaur on 4/27/22.
//

import Foundation


class GFFollowerItemVC: GFItemInfoVC {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
        
    }
    
    private func configureItems() {
        // want to specify itemInfoView to repo
        itemInfoViewOne.set(itemInfoType: .followers, withCount: user.followers)
        itemInfoViewTwo.set(itemInfoType: .following, withCount: user.following)
        actionButton.set(backgroundColor: .systemGreen, title: "Get Followers")
    }
    
    // when we tap the follower button -> our ItemInfoVC will say "hey delegate" which is the UserInfoVC -> UserInfoVC need sto pass that information along to FollowerListVC
    override func actionButtonTapped() {
        delegate.didTapGetFollowers(for: user)
    }
}
