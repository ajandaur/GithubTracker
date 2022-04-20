//
//  NetworkManager.swift
//  GithubTracker
//
//  Created by Anmol  Jandaur on 4/20/22.
//

import Foundation

class NetworkManager {
    // create the singleton
    static let shared = NetworkManager()
    let baseURL = "https://api.github.com/users/"
    let perPageFollowers = 100
    
    private init() { }
    
    // f(x) to return an array of followers
    func getFollower(for username: String, page: Int, completed: @escaping ([Follower]?, String?) -> Void) {
        
        let endpoint = baseURL + "\(username)/followers?per_page=\(perPageFollowers)&page=\(page)"
        
        // check that we have a valid URL
        guard let url = URL(string: endpoint) else {
            completed(nil, "This username created an invalid request, Please try again.")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            // handling error
            if let _ = error {
                completed(nil, "Unable to complete your request. Please check your internet connection")
                return
            }
            
            // if this response is not nil, put it as a response and check if it is 200 (OK)
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(nil, "Invalid response from the server, please try again.")
                return
            }
            
            // handle data
            guard let data = data else {
                completed(nil, "The data received from the server was invalid. Please try again.")
                return
            }
            
            do {
                // take JSON and decode into our model objects
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Follower].self, from: data)
                completed(followers, nil)
            } catch {
                completed(nil, "The data received from the server was invalid. Please try again.")
            }
        }
        task.resume()
    }
}

