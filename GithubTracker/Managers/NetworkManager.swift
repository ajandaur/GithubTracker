//
//  NetworkManager.swift
//  GithubTracker
//
//  Created by Anmol  Jandaur on 4/20/22.
//

import UIKit
class NetworkManager {
    
    // create the singleton
    static let shared = NetworkManager()
    let baseURL = "https://api.github.com/users/"
    let perPageFollowers = 100
    let cache = NSCache<NSString, UIImage>()
    let decoder = JSONDecoder()
    
    
    private init() {
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
    }
    
    // f(x) to return an array of followers
    func getFollower(for username: String, page: Int) async throws -> [Follower] {
        
        let endpoint = baseURL + "\(username)/followers?per_page=\(perPageFollowers)&page=\(page)"
        
        // check that we have a valid URL
        guard let url = URL(string: endpoint) else {
            throw GFError.invalidData
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        // if this response is not nil, put it as a response and check if it is 200 (OK)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw GFError.invalidResponse
        }
        
        
        do {
            // take JSON and decode into our model objects
            return try decoder.decode([Follower].self, from: data)
        } catch {
            throw GFError.invalidData
        }
    }
    
    func getUserInfo(for username: String) async throws -> User {
        
        let endpoint = baseURL + "\(username)"
        
        // check that we have a valid URL
        guard let url = URL(string: endpoint) else {
            throw GFError.invalidData
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        // if this response is not nil, put it as a response and check if it is 200 (OK)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw GFError.invalidResponse
        }
        
        
        do {
            // take JSON and decode into our model objects
            return try decoder.decode(User.self, from: data)
        } catch {
            throw GFError.invalidData
        }
    }
    
    func downloadImage(from urlString: String) async -> UIImage? {
        let cacheKey = NSString(string: urlString)
        
        // need to pass in unique key, in this case it is the url
        if let image = cache.object(forKey: cacheKey) { return image }
        
        // continue if we DON'T have the cached image
        guard let url = URL(string: urlString) else { return nil }
        
        
        do {
            
            // we don't care about the response or error
            let (data, _) = try await URLSession.shared.data(from: url)
            
            guard let image = UIImage(data:data) else { return nil }
            cache.setObject(image, forKey: cacheKey)
            return image
        } catch {
            return nil
        }
        
    }
}


