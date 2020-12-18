//
//  SocialsViewController.swift
//  Ve-scoverer
//
//  Created by Francis Adewale on 18/12/2020.
//

import UIKit

class SocialsViewController: UIViewController, UITextFieldDelegate {
    
    var instagramWebLink = "https://instagram.com/"
    var twitterWebLink = "https://twitter.com/"
    
    @IBOutlet weak var fullInstagramLink: UILabel!
    
    @IBOutlet weak var fullTwitterLink: UILabel!
    
    @IBOutlet weak var usersInstagram: UITextField!
    
    @IBOutlet weak var usersTwitter: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        usersInstagram.delegate = self
        usersTwitter.delegate = self
        
        
        
    }
    
    func textFieldDidBeginEditing(textField: UITextField!) {
        
        instagramWebLink += usersInstagram.text!
        twitterWebLink += usersTwitter.text!
        
       

        
    }

    func textFieldShouldEndEditing(textField: UITextField!) -> Bool {  print(instagramWebLink)
        return false
    }

    func textFieldShouldReturn(textField: UITextField!) -> Bool {   //delegate method
      textField.resignFirstResponder()
        fullInstagramLink.text = instagramWebLink
        fullTwitterLink.text = twitterWebLink
        

        return true
    }
    
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}
