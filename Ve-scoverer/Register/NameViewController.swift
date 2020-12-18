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
        
        
        hideKeyboardWhenTappedAround()

    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    


    @IBAction func next(_ sender: Any) {
        
        let avc = storyboard?.instantiateViewController(withIdentifier: "Age") as! AgeViewController
        
        avc.modalPresentationStyle = .overFullScreen
        
        present(avc, animated: false, completion: nil)
        
    }
    
}
