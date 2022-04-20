//
//  User.swift
//  GithubTracker
//
//  Created by Anmol  Jandaur on 4/20/22.
//

import Foundation

struct User: Codable {
    var login: String
    var avatarUrl: String
    
    // may not have these..
    var name: String?
    var location: String?
    var bio: String?
    
    
    var publicRepos: Int
    var publicists: Int
    var htmlUrl: String
    var following: Int
    var followers: Int
    var createdAt: String
}
