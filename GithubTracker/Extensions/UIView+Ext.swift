//
//  UIView+Ext.swift
//  GithubTracker
//
//  Created by Anmol  Jandaur on 4/30/22.
//

import UIKit

extension UIView {
    
    func addSubviews(_ views: UIView...) {
        for view in views {
            addSubviews(view)
        }
    }
}

