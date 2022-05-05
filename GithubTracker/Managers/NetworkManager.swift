//
//  NetworkManager.swift
//  GithubTracker
//
//  Created by Anmol  Jandaur on 4/20/22.
//

import UIKit
// f(x) to return an array of followers
//    func getFollower(for username: String, page: Int, completed: @escaping (Result<[Follower], GFError>) -> Void) {
//
//        let endpoint = baseURL + "\(username)/followers?per_page=\(perPageFollowers)&page=\(page)"
//
//        // check that we have a valid URL
//        guard let url = URL(string: endpoint) else {
//            completed(.failure(.invalidUsername))
//            return
//        }
//
//        let task = URLSession.shared.dataTask(with: url) { data, response, error in
//
//            // handling error
//            if let _ = error {
//                completed(.failure(.unabletoComplete))
//                return
//            }
//
//            // if this response is not nil, put it as a response and check if it is 200 (OK)
//            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
//                completed(.failure(.invalidResponse))
//                return
//            }
//
//            // handle data
//            guard let data = data else {
//                completed(.failure(.invalidData))
//                return
//            }
//
//            do {
//                // take JSON and decode into our model objects
//                let decoder = JSONDecoder()
//                decoder.keyDecodingStrategy = .convertFromSnakeCase
//                let followers = try decoder.decode([Follower].self, from: data)
//                completed(.success(followers))
//            } catch {
//                completed(.failure(.invalidData))
//            }
//        }
//        task.resume()
//    }

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
    
    // Implementing async await for this API call
    func getFollower(for username: String, page: Int) async throws -> [Follower] {
        
        let endpoint = baseURL + "\(username)/followers?per_page=\(perPageFollowers)&page=\(page)"
        
        // check that we have a valid URL
        guard let url = URL(string: endpoint) else {
            throw GFError.invalidUsername
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        // if this response is not nil, put it as a response and check if it is 200 (OK)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw GFError.invalidResponse
        }
        
        
        do {
            return try decoder.decode([Follower].self, from: data)
        } catch {
            throw GFError.invalidData
        }
    }
}

func getUserInfo(for username: String, completed: @escaping (Result<User, GFError>) -> Void) {
    
    let endpoint = baseURL + "\(username)"
    
    // check that we have a valid URL
    guard let url = URL(string: endpoint) else {
        completed(.failure(.invalidUsername))
        return
    }
    
    let task = URLSession.shared.dataTask(with: url) { data, response, error in
        
        // handling error
        if let _ = error {
            completed(.failure(.unabletoComplete))
            return
        }
        
        // if this response is not nil, put it as a response and check if it is 200 (OK)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            completed(.failure(.invalidResponse))
            return
        }
        
        // handle data
        guard let data = data else {
            completed(.failure(.invalidData))
            return
        }
        
        do {
            // take JSON and decode into our model objects
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            let user = try decoder.decode(User.self, from: data)
            completed(.success(user))
        } catch {
            completed(.failure(.invalidData))
        }
    }
    task.resume()
}

func downloadImage(from urlString: String, completed: @escaping (UIImage?) -> Void) {
    let cacheKey = NSString(string: urlString)
    
    // need to pass in unique key, in this case it is the url
    if let image = cache.object(forKey: cacheKey) {
        completed(image)
        return
    }
    
    // continue if we DON'T have the cached image
    
    guard let url = URL(string: urlString) else {
        completed(nil)
        return
        
    }
    
    let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
        guard let self = self,
              error == nil,
              let response = response as? HTTPURLResponse, response.statusCode == 200,
              let data = data,
              let image = UIImage(data:data) else {
                  completed(nil)
                  return
              }
        
        self.cache.setObject(image, forKey: cacheKey)
        
        completed(image)
        
    }
    
    task.resume()
}


