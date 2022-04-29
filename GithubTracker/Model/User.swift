//
//  User.swift
//  GithubTracker
//
//  Created by Anmol  Jandaur on 4/20/22.
//

import Foundation

struct User: Codable {
    let login: String
    let avatarUrl: String
    
    // may not have these..
    var name: String?
    var location: String?
    var bio: String?
    
    
    let publicRepos: Int
    let publicGists: Int
    let htmlUrl: String
    let following: Int
    let followers: Int
    let createdAt: Date
}
