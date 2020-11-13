//
//  DiscoverViewController.swift
//  Ve-scoverer
//
//  Created by Francis Adewale on 05/11/2020.
//

import UIKit
import MapKit
import CoreLocation
import Firebase

class DiscoverViewController: UIViewController {
    //MARK: - Properties
    let startingLocation = CLLocation(latitude: 37.773972, longitude: -122.431297)
    var longitude = CLLocationDegrees()
    var latitude = CLLocationDegrees()
    private let locationManager = CLLocationManager()
    let radius: CLLocationDistance = 500
    var annoationsArray = [MKPointAnnotation]()
    let db = Firestore.firestore()

    
    
    @IBOutlet weak private var nearbyUsers: MKMapView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
//        db.collection("users").getDocuments() {(querySnapshot, err) in
//            if let err = err {
//                print("Error getting documents: \(err)")
//            } else {
//                for document in querySnapshot!.documents {
//
//
//                    //self.nearbyUsers.showAnnotations(self.annoationsArray, animated: true)
//                }
//            }
//        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setStartingPosition()
        let geo = getGeoLocation()
        setAnnotation(geoPoint: geo)
    
        nearbyUsers.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyReduced
            locationManager.startUpdatingLocation()
        }
        
    }
    
    func getGeoLocation() -> [GeoPoint]{
            return [
                GeoPoint(latitude: 37.788666, longitude: -123.107540),
                GeoPoint(latitude: 37.788300, longitude: -122.407570),
                GeoPoint(latitude: 37.788999, longitude: -122.507570),
                GeoPoint(latitude: 37.788133, longitude: -122.404470)
            ]
        }
    
    func setAnnotation(geoPoint:[GeoPoint]){
            
            for point in geoPoint {
                let annotation = MKPointAnnotation()
                //annotation.title = store.name
                
                
                annotation.coordinate = CLLocationCoordinate2D(latitude: point.latitude, longitude: point.longitude)
                nearbyUsers.addAnnotation(annotation)
                annoationsArray.append(annotation)
                nearbyUsers.showAnnotations(annoationsArray, animated: true)
                
            }
    }
    
    func setStartingPosition(){
            
        let position =  MKCoordinateRegion(center: startingLocation.coordinate,
                                               latitudinalMeters: radius,
                                               longitudinalMeters: radius)
        
        nearbyUsers.setRegion(position, animated: true)
    }
}

//MARK: - CoreLocation Methods
extension DiscoverViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        
        self.locationManager.stopUpdatingLocation()
        
//        var insertion = MKPointAnnotation()
//
//        insertion.coordinate.longitude = (locations.last?.coordinate.longitude)!
//        insertion.coordinate.latitude = (locations.last?.coordinate.latitude)!
//
//        annoationsArray.append(insertion)
//
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
}

//MARK: - MapKit Methods

extension DiscoverViewController: MKMapViewDelegate {
        
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        let alert = UIAlertController(title: "View User", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            if let loc = view.annotation?.coordinate {
                print("This is loc: \(loc)")
            }
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
                
    }
    

}
