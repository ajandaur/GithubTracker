//
//  GFTitleLabel.swift
//  GithubTracker
//
//  Created by Anmol  Jandaur on 4/18/22.
//

import UIKit

class GFTitleLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // when we use convenience init, we call the initial init() to avoid having to configure() in every initializer1
    convenience init(textAlignment: NSTextAlignment, fontSize: CGFloat) {
        self.init(frame: .zero)
        // set alignment
        self.textAlignment = textAlignment
        // set font
        self.font = UIFont.systemFont(ofSize: fontSize, weight: .bold)
    }
    
    // configure title label
    private func configure() {
        textColor = .label
        // shrink label if it is too long
        adjustsFontSizeToFitWidth = true
        // limit shrinking of font
        minimumScaleFactor = 0.9
        lineBreakMode = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false
    }
    

}
