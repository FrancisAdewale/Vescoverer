//
//  NameViewController.swift
//  Ve-scoverer
//
//  Created by Francis Adewale on 17/12/2020.
//

import UIKit
import RealmSwift


class NameViewController: UIViewController, UITextFieldDelegate {
    
    let realm = try! Realm()
    
    
    var userName = NormalUser()


    var firstName = ""
    var lastName = ""
    var usersid = ""


    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let user = realm.objects(RealmUser.self)
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        
        
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
        
        userName.firstName = firstNameTextField.text!
        userName.lastName = lastNameTextField.text!
        
        print(firstNameTextField.text)
        
        let avc = storyboard?.instantiateViewController(withIdentifier: "Age") as! AgeViewController
        
        avc.modalPresentationStyle = .overFullScreen
        
        present(avc, animated: false, completion: nil)
        
    }
    
}
