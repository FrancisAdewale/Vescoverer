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
import AuthenticationServices
import GoogleSignIn


class LoginViewController: UIViewController, CLLocationManagerDelegate, GIDSignInDelegate {
    
    let context = (UIApplication.shared.delegate as! AppDelegate)
    
    let db = Firestore.firestore()
    let btnAuthorization = ASAuthorizationAppleIDButton()
    var location = CLLocation()
    private let locationManager = CLLocationManager()
    var firstName = ""


        
//    @IBOutlet weak var loginLabel: UIButton!
//    @IBOutlet weak var registerLabel: UIBarButtonItem!
//    @IBOutlet weak var registerBar: UIToolbar!
//    @IBOutlet weak var emailTextField: UITextField!
//    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewWillAppear(_ animated: Bool) {
        self.modalPresentationStyle = .fullScreen
        view.backgroundColor = UIColor(hexString: "3797A4")
        navigationItem.hidesBackButton = true
//        loginLabel.tintColor = .white
        

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupSOAppleSignIn()
        
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance()?.delegate = self

        
        // Automatically sign in the user.

        hideKeyboardWhenTappedAround()

    }

    

    
        func setupSOAppleSignIn() {
    
             btnAuthorization.frame = CGRect(x: 0, y: 0, width: 200, height: 40)
    
             btnAuthorization.center = self.view.center
    
             btnAuthorization.addTarget(self, action: #selector(handleAuthorizationAppleIDButtonPress), for: .touchUpInside)
                
             self.view.addSubview(btnAuthorization)
    
         }
    
    
        @objc
        func handleAuthorizationAppleIDButtonPress() {
            let appleIDProvider = ASAuthorizationAppleIDProvider()
            let request = appleIDProvider.createRequest()
            request.requestedScopes = [.fullName, .email]
    
            let authorizationController = ASAuthorizationController(authorizationRequests: [request])
            authorizationController.delegate = self
            authorizationController.presentationContextProvider = self
            authorizationController.performRequests()
        }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
//    @IBAction func registerPressed(_ sender: UIBarButtonItem) {
//
//        let rvc = storyboard?.instantiateViewController(identifier: "register") as! RegisterViewController
//        rvc.modalPresentationStyle = .fullScreen
//        present(rvc, animated: true, completion: nil)
//
//    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.last!
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    
//    @IBAction func userLogin(_ sender: UIButton) {
//
//        locationManager.requestAlwaysAuthorization()
//        locationManager.requestWhenInUseAuthorization()
//
//        if CLLocationManager.locationServicesEnabled() {
//            locationManager.delegate = self
//            locationManager.desiredAccuracy = kCLLocationAccuracyReduced
//            locationManager.startUpdatingLocation()
//        }
//
//        let dvc =  self.storyboard?.instantiateViewController(withIdentifier: "Dashboard") as! DashboardTabController
//        dvc.modalPresentationStyle = .fullScreen
//
//        if let email = emailTextField.text, let password = passwordTextField.text {
//
//            Auth.auth().signIn(withEmail: email, password: password) { (authresult, error) in
//                if let e = error {
//                    print(e)
//                } else {
//                    let user = User(email: email, password: password, userCoordinate: self.location.coordinate)
//
//                    self.db.collection("users").document(user.email).setData([
//                        "longitude": Double(user.userCoordinate!.longitude),
//                        "latitude": Double(user.userCoordinate!.latitude)
//                    ]) { err in
//                        if let err = err {
//                            print("Error writing document: \(err)")
//                        } else {
//                            print("Document successfully written!")
//                        }
//                    }
//
//                    self.present(dvc, animated: true, completion: nil)
//
//                }
//            }
//        }
//
//    }
    
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
          withError error: Error!) {
        if let error = error {
            print("\(error.localizedDescription)")
        } else {
            
            let user = user.profile
            firstName = (user?.givenName)!
            print(firstName)
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vVc = storyboard.instantiateViewController(withIdentifier: "Vegan") as! VeganViewController
            vVc.modalPresentationStyle = .overFullScreen
            self.present(vVc, animated: false, completion: nil)
        }
    }

    

}


extension LoginViewController: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
                case let appleIDCredential as ASAuthorizationAppleIDCredential:
                    let userIdentifier = appleIDCredential.user

                    let defaults = UserDefaults.standard
                    defaults.set(userIdentifier, forKey: "userIdentifier1")
                    print(userIdentifier)

                    var appleId = userIdentifier

                   // self.present(UINavigationController(rootViewController: vc), animated: true)
                    break
                default:
                    break
                }
    }

}

extension LoginViewController: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }


}



