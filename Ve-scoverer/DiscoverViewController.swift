//
//  DiscoverViewController.swift
//  Ve-scoverer
//
//  Created by Francis Adewale on 05/11/2020.
//

import UIKit
import MapKit
import CoreLocation

class DiscoverViewController: UIViewController {
    //MARK: - Properties
    let fvc = FoundTableViewController()
    
    var users = [CLLocationCoordinate2D]()
    var longitude = CLLocationDegrees()
    var latitude = CLLocationDegrees()
    private let locationManager = CLLocationManager()
    
    
    
    @IBOutlet weak private var nearbyUsers: MKMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nearbyUsers.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyReduced
            locationManager.startUpdatingLocation()
        }
        
    }
}

//MARK: - CoreLocation Methods
extension DiscoverViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        print("this is location \(location)")
        let annotation = MKPointAnnotation()
        
        latitude = location!.coordinate.latitude
        longitude = location!.coordinate.longitude
        let center = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))
        
        annotation.coordinate = center
        annotation.title = "User"
        
        
        self.nearbyUsers.setRegion(region, animated: true)
        nearbyUsers.addAnnotation(annotation)
        self.locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
}

//MARK: - MapKit Methods

extension DiscoverViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        guard annotation is MKPointAnnotation else {
            return nil
        }
        let identifier = "Annotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView!.canShowCallout = true
        } else {
            annotationView!.annotation = annotation
        }
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        let alert = UIAlertController(title: "View User", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            if let loc = view.annotation?.coordinate {
                self.fvc.userArray.append(loc)
                print(self.fvc.userArray)
            }
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
        
    }
    
}

