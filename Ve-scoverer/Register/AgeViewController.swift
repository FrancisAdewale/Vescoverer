//
//  AgeViewController.swift
//  Ve-scoverer
//
//  Created by Francis Adewale on 17/12/2020.
//

import UIKit

class AgeViewController: UIViewController {

    @IBOutlet weak var ageSelector: UIDatePicker!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ageSelector.datePickerMode = .date
        // Do any additional setup after loading the view.
    }
    



}
