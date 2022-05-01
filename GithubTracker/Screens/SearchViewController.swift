//
//  SearchViewController.swift
//  GithubTracker
//
//  Created by Anmol  Jandaur on 4/17/22.
//

import UIKit

class SearchViewController: UIViewController {
    
    
    let logoImageView = UIImageView()
    
    let usernameTextField = GFTextField()
    let callToActionButton = GFButton(backgroundColor: .systemGreen, title: "Get Followers")
    
    // use computed property for text validation
    var isUsernameEntered: Bool {
        // return true if there is something in the text field
        return !usernameTextField.text!.isEmpty
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        view.addSubviews(logoImageView, usernameTextField, callToActionButton)
        configureLogoImageView()
        configureTextField()
        configureCallToActionButton()
        createDismissKeyboardTapGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        usernameTextField.text = ""
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    // when you use #selector, we need to expose its function in the parameter to @objc
    @objc func pushFollowerListVC() {
        guard isUsernameEntered else {
            presentGFAlertOnMainThread(title: "Empty Username", message: "Please enter a username. We need to know who to look for 😬", buttonTitle: "Ok")
            return
        }
        
        usernameTextField.resignFirstResponder()
        
        // create the object
        let followerListVC = FollowerListViewController(username: usernameTextField.text!)
        // push the view controller onto the stack
        navigationController?.pushViewController(followerListVC, animated: true)
    }
    
    func configureLogoImageView() {
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = Images.GHLogo
        
        NSLayoutConstraint.activate([
            // add an array of constraints
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            // center this in the view
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            // height and width constraints
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    func configureTextField() {
        // NEED TO SET THE DELEGATE TO SELF (SearchVC in this case)
        usernameTextField.delegate = self
        
        NSLayoutConstraint.activate([
            usernameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
            // width and height
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            usernameTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func configureCallToActionButton() {
        callToActionButton.addTarget(self, action: #selector(pushFollowerListVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            callToActionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            callToActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            callToActionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            callToActionButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }


}

extension SearchViewController: UITextFieldDelegate {
    // when we conform to a delegate, we are going to listen to it
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // code fires when you press the button
        pushFollowerListVC()
        
        return true
    }
}
