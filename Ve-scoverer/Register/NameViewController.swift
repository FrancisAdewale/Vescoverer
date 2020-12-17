//
//  NameViewController.swift
//  Ve-scoverer
//
//  Created by Francis Adewale on 17/12/2020.
//

import UIKit

class NameViewController: UIViewController {

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let lvc = storyboard?.instantiateViewController(withIdentifier: "Login") as! LoginViewController
        
        firstNameTextField.text = lvc.firstName
        

    }
    



}
