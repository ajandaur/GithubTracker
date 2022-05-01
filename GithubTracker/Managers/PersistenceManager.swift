//
//  PersistenceManager.swift
//  GithubTracker
//
//  Created by Anmol  Jandaur on 4/28/22.
//

import Foundation

enum PersistenceActionType {
    // how do we know whether we are adding or removing follower data?
    case add, remove
}

enum PersistenceManager {
    
    static private let defaults = UserDefaults.standard
    
    // enum to hold our constants
    enum Keys {
        static let favorites = "favorites"
    }
    
    // pass in our follower and check whether it is adding or removing and f(x) will return error if unable to do so
    static func updateWith(favorite: Follower, actionType: PersistenceActionType, completed: @escaping (GFError?) -> Void) {
        // reach into UserDefaults to do the action
        retrieveFavorites { result in
            switch result {
            case .success(var favorites):
                
                switch actionType {
                case . add:
                    // don't want to add a favorite if that favorite already exists..
                    guard !favorites.contains(favorite) else {
                        completed(.alreadyInFavorites)
                        return
                    }
                    
                    favorites.append(favorite)
                
                // when we use swipe to delete on TableView
                case .remove:
                    favorites.removeAll { $0.login == favorite.login }
                }
                
                completed(save(favorites: favorites))
                
            case .failure(let error):
                completed(error)
            }
        }
    }
    
    static func retrieveFavorites(completed: @escaping (Result<[Follower], GFError>) -> Void) {
        // reach into UserDefaults and looking at what we have..
        guard let favoritesData = defaults.object(forKey: Keys.favorites) as? Data else {
            // if nothing is there, return a blank array (i.e. first time using it)
            completed(.success([]))
            return
        }
        // decode the data into Follower array using do-catch block
        do {
            // take JSON and decode into our model objects
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([Follower].self, from: favoritesData)
            completed(.success(favorites))
        } catch {
            // else return a error message for the .unableToFavorite case of the enum
            completed(.failure(.unableToFavorite))
        }
    }
    
    static func save(favorites: [Follower]) -> GFError? {
        
        do {
            let encodedFavorites = try JSONEncoder().encode(favorites)
            // save the encodedFavorites to the UserDefaults
            defaults.set(encodedFavorites, forKey: Keys.favorites)
            // return nil because there is no GFError?
            return nil
        } catch {
            // return error if unable to encode data
            return .unableToFavorite
        }
    }
    
}
