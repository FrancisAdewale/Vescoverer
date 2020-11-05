//
//  ViewController.swift
//  Ve-scoverer
//
//  Created by Francis Adewale on 03/11/2020.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet private weak var isVegan: UISwitch! // may need coredata
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Ve-scoverer"
        isVegan.isOn = false
    }
    
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        if isVegan.isOn {
            return true
        }
        return false
    }
}

