//
//  ErrorMessage.swift
//  GithubTracker
//
//  Created by Anmol  Jandaur on 4/20/22.
//

import Foundation

enum GFError: String, Error {
    case invalidUsername    = "This username created an invalid request, Please try again."
    case unabletoComplete   = "Unable to complete your request. Please check your internet connection"
    case invalidResponse    = "Invalid response from the server, please try again."
    case invalidData        = "The data received from the server was invalid. Please try again."
}
