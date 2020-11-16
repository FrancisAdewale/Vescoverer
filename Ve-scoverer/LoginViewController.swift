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

        
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewWillAppear(_ animated: Bool) {
        self.modalPresentationStyle = .fullScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        load()
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

//                    var ref: DocumentReference = user.email
//                    ref = self.db.collection("users").addDocument(data: [
//                        "longitude": Double(self.location.coordinate.longitude),
//                        "latitude": Double(self.location.coordinate.latitude)
//                    ]) { err in
//                        if let err = err {
//                            print("Error adding document: \(err)")
//                        } else {
//                            print("Document added with ID: \(ref!.documentID)")
//                        }
//                    }
//
//                    ref = self.db.collection("users").addDocument(data: [
//                        "longitude":-122.21108,
//                        "latitude": 37.620
//                    ]) { err in
//                        if let err = err {
//                            print("Error adding document: \(err)")
//                        } else {
//                            print("Document added with ID: \(ref!.documentID)")
//                        }
//                    }
//
//                    ref = self.db.collection("users").addDocument(data: [
//                        "longitude": -122.20459,
//                        "latitude":37.500
//                    ]) { err in
//                        if let err = err {
//                            print("Error adding document: \(err)")
//                        } else {
//                            print("Document added with ID: \(ref!.documentID)")
//                            ref?.set
//                        }
//                    }
                    
                    self.present(dvc, animated: true, completion: nil)

                }
            }
        }
        
    }
    
//    func save() {
//
//        do {
//            try context.save()
//        } catch {
//            print(error)
//        }
//    }
//
//    func load() {
//
//        let fetchRequest = NSFetchRequest<Location>(entityName: "Location")
//
//        let request = try? context.fetch(fetchRequest)
//
//        userCordinates = request!
//
//
//    }
}


