//
//  RegisterViewController.swift
//  Ve-scoverer
//
//  Created by Francis Adewale on 03/11/2020.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {
    
    let db = Firestore.firestore()
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField! //UIPICKER for age instead
    
    override func viewDidLoad() {
        super .viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.hidesBackButton = true
    }
    
    // rename function name
    @IBAction func donePressed(_ sender: UIButton) {
        
        let user = User(email: emailTextField.text!, password: passwordTextField.text!)
        
        Auth.auth().createUser(withEmail: user.email, password: user.password) { (result, error) in
            if let e = error {
                print(e)
            } else {
                let dvc =  self.storyboard?.instantiateViewController(withIdentifier: "Dashboard") as! DashboardTabController
                dvc.modalPresentationStyle = .fullScreen
                self.present(dvc, animated: true, completion: nil)
                
            }
        }
    }
    
    
    @IBAction func loginPressed(_ sender: UIBarButtonItem) {
        
        self.performSegue(withIdentifier: "goToLogin", sender: self)
        
    }
    
}
