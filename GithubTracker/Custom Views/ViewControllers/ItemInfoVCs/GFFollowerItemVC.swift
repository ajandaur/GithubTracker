//
//  GFFollowerItemVC.swift
//  GithubTracker
//
//  Created by Anmol  Jandaur on 4/27/22.
//

import Foundation

protocol GFFollowerItemVCDelegate: AnyObject {
    func didTapGetFollowers(for user: User)
}

class GFFollowerItemVC: GFItemInfoVC {
    
    weak var delegate: GFFollowerItemVCDelegate!
    
    init(user: User, delegate: GFFollowerItemVCDelegate) {
        super.init(user: user)
        self.delegate = delegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
        
    }
    
    private func configureItems() {
        // want to specify itemInfoView to repo
        itemInfoViewOne.set(itemInfoType: .followers, withCount: user.followers)
        itemInfoViewTwo.set(itemInfoType: .following, withCount: user.following)
        actionButton.set(color: .systemGreen, title: "Get Followers", systemImageName: "person.3")
    }
    
    // when we tap the follower button -> our ItemInfoVC will say "hey delegate" which is the UserInfoVC -> UserInfoVC need sto pass that information along to FollowerListVC
    override func actionButtonTapped() {
        delegate.didTapGetFollowers(for: user)
    }
}
