//
//  LoginViewController.swift
//  Ve-scoverer
//
//  Created by Francis Adewale on 04/11/2020.
//

import UIKit
import Firebase
import CoreLocation
import CoreData

class LoginViewController: UIViewController, CLLocationManagerDelegate  {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let db = Firestore.firestore()

    
    var location = CLLocation()
    private let locationManager = CLLocationManager()

        
    @IBOutlet weak var loginLabel: UIButton!
    @IBOutlet weak var registerLabel: UIBarButtonItem!
    @IBOutlet weak var registerBar: UIToolbar!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewWillAppear(_ animated: Bool) {
        self.modalPresentationStyle = .fullScreen
        view.backgroundColor = UIColor(hexString: "3797A4")
        registerBar.barTintColor = UIColor(hexString: "3797A4")
        registerLabel.tintColor = .white
        navigationItem.hidesBackButton = true
        loginLabel.tintColor = .white

    }
    
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
    
    
    @IBAction func registerPressed(_ sender: UIBarButtonItem) {
        
        let rvc = storyboard?.instantiateViewController(identifier: "register") as! RegisterViewController
        rvc.modalPresentationStyle = .fullScreen
        present(rvc, animated: true, completion: nil)
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.last!
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    @IBAction func userLogin(_ sender: UIButton) {
        
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyReduced
            locationManager.startUpdatingLocation()
        }
        
        let dvc =  self.storyboard?.instantiateViewController(withIdentifier: "Dashboard") as! DashboardTabController
        dvc.modalPresentationStyle = .fullScreen
        
        if let email = emailTextField.text, let password = passwordTextField.text {
            
            Auth.auth().signIn(withEmail: email, password: password) { (authresult, error) in
                if let e = error {
                    print(e)
                } else {
                    let user = User(email: email, password: password, userCoordinate: self.location.coordinate)
                    
                    self.db.collection("users").document(user.email).setData([
                        "longitude": Double(user.userCoordinate!.longitude),
                        "latitude": Double(user.userCoordinate!.latitude)
                    ]) { err in
                        if let err = err {
                            print("Error writing document: \(err)")
                        } else {
                            print("Document successfully written!")
                        }
                    }

                    self.present(dvc, animated: true, completion: nil)

                }
            }
        }
        
    }
    

}


