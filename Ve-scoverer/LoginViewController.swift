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
                    
                    let geoLocation = GeoPoint(latitude: Double(self.location.coordinate.latitude), longitude: Double(self.location.coordinate.longitude))

                    
                    var ref: DocumentReference? = nil
                    ref = self.db.collection("users").addDocument(data: [
                        "longitude": geoLocation.longitude,
                        "latitude": geoLocation.latitude
                    ]) { err in
                        if let err = err {
                            print("Error adding document: \(err)")
                        } else {
                            print("Document added with ID: \(ref!.documentID)")
                        }
                    }
                    
                    ref = self.db.collection("users").addDocument(data: [
                        "longitude": -0.320119,
                        "latitude": 51.602938
                    ]) { err in
                        if let err = err {
                            print("Error adding document: \(err)")
                        } else {
                            print("Document added with ID: \(ref!.documentID)")
                        }
                    }
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


