//
//  HistoryViewController.swift
//  ForaSoft-assignment
//
//  Created by Nihad on 1/13/21.
//

import UIKit

class HistoryViewController: UIViewController {
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureNavBar()
    }
    
    // MARK: - Helpers
    
    func configureNavBar() {
        navigationItem.title = "History"
    }
    
    func configureUI() {
        view.backgroundColor = .white
        
    }
    
}
