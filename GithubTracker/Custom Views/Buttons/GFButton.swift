//
//  GFButton.swift
//  GithubTracker
//
//  Created by Anmol  Jandaur on 4/18/22.
//

import UIKit

class GFButton: UIButton {
    
    // GFButton is a child of UIButton
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    // When we initialize it for Storyboard, this init needs to be initialized
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(backgroundColor: UIColor, title: String) {
        self.init(frame: .zero)
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)

    }
    
    private func configure() {
        layer.cornerRadius = 10
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        translatesAutoresizingMaskIntoConstraints = false
        setTitleColor(.white, for: .normal)
    }
    
    func set(backgroundColor: UIColor, title: String) {
        self.backgroundColor = backgroundColor
        setTitle(title, for: .normal)
    }
    
}
