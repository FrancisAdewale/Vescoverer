//
//  ProfileViewController.swift
//  Ve-scoverer
//
//  Created by Francis Adewale on 04/11/2020.
//

import UIKit

class DashboardTabController: UITabBarController {
    
    @IBOutlet weak var dashboardTab: UITabBar!
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.hidesBackButton = true
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        print(tabBar.selectedItem)
    }
    
    
}


