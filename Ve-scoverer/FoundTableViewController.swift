//
//  FoundTableViewController.swift
//  Ve-scoverer
//
//  Created by Francis Adewale on 06/11/2020.
//

import UIKit
import Firebase
import CoreLocation


class FoundTableViewController: UITableViewController {
    
    let db = Firestore.firestore()
    var userArray = [[String:Any]]()
    
    var userList = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        load()
    }
    
    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        //return Array(userArray).count
        return userList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "reusableCell", for: indexPath)
        let label = userList[indexPath.row]
        cell.textLabel?.text = label
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected")
    }
    
    
    func load() {
        db.collection("users").getDocuments() {(querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                
                for document in querySnapshot!.documents {
                    
                    print(document)
                   
                    
                    
                    self.userList.append(document.documentID)
                    
                    
                    //self.userArray.append(data)
                    
                    
//                    let data = document.data()
//
//                    let latituide = data["latitude"] as? Double ?? 0
//                    let longitude = data["longitude"] as? Double ?? 0
//
//                    self.found.append(latituide)
                    
//                    for _ in self.userArray {
//                        let longitude = (self.userArray["longitude"] as! Double)
//                        let latitude = (self.userArray["latitude"] as! Double)
//
//                        var coordinate = CLLocationCoordinate2D() //+37.76578140,-122.40755380
//
//                        coordinate.longitude = longitude
//                        coordinate.latitude = latitude
//
////                                print(coordinate)
//
//
//                        self.found?.append(coordinate)
//
//                    }
//
                    
                }
                print(self.userArray.count)

                
                self.tableView.reloadData()

            }
        }
    }
 



}
