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
    
    convenience init(color: UIColor, title: String, systemImageName: String) {
        self.init(frame: .zero)
        set(color: color, title: title, systemImageName: systemImageName)
    }
    
    private func configure() {
        
        configuration = .tinted()
        
        configuration?.cornerStyle = .medium
        
        
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func set(color: UIColor, title: String, systemImageName: String) {
        
        configuration?.baseBackgroundColor = color
        configuration?.baseForegroundColor = color
        configuration?.title = title
        
        configuration?.image = UIImage(systemName: systemImageName)
        configuration?.imagePlacement = .leading
    }
    
}
