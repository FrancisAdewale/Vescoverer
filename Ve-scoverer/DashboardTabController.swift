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
        super.viewWillAppear(animated)
        
        dashboardTab.barTintColor = UIColor(hexString: "3797A4")
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        title = "Ve-scoverer"
        
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
        
    }
    
    
}


