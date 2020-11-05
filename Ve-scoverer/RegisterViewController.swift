//
//  RegisterViewController.swift
//  Ve-scoverer
//
//  Created by Francis Adewale on 03/11/2020.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {
    
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
        let identifier = UUID()
        let user = User(id: identifier, email: emailTextField.text!, password: passwordTextField.text!, age: ageTextField.text!)
        
        Auth.auth().createUser(withEmail: user.email, password: user.password) { (result, error) in
            if let e = error {
                print(e)
            } else {
                let pvc =  self.storyboard?.instantiateViewController(withIdentifier: "profile") as! DashboardTabController
                pvc.modalPresentationStyle = .fullScreen
                self.present(pvc, animated: true, completion: nil)            }
        }
    }
    
    
    @IBAction func loginPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "goToLogin", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //segue.destination = Login
    }
}
