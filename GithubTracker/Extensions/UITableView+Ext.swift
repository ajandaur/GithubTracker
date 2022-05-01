//
//  UITableView+Ext.swift
//  GithubTracker
//
//  Created by Anmol  Jandaur on 4/30/22.
//

import UIKit

extension UITableView {
    
    func reloadDataOnMainThread() {
        DispatchQueue.main.async { self.reloadData() }
    }
    
    func removeExcessCells() {
        tableFooterView = UIView(frame: .zero)
        
    }
    
    
}
