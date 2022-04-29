//
//  GFSecondaryTitleLabel.swift
//  GithubTracker
//
//  Created by Anmol  Jandaur on 4/24/22.
//

import UIKit

class GFSecondaryTitleLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(fontSize: CGFloat) {
        self.init(frame: .zero)
        // set font size
        font = UIFont.systemFont(ofSize: fontSize, weight: .medium)
    }
    
    // configure title label
    private func configure() {
        textColor = .secondaryLabel
        // shrink label if it is too long
        adjustsFontSizeToFitWidth = true
        // limit shrinking of font
        minimumScaleFactor = 0.90
        lineBreakMode = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false
    }

}
