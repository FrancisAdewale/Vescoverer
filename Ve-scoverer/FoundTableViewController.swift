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
    
    var found = [CLLocationCoordinate2D]()
        
    


    override func viewDidLoad() {
        super.viewDidLoad()

     
       
        
        load()
        
    }
    
    

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return Array(userArray).count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "reusableCell", for: indexPath)
        
        let label = Array(userArray)[indexPath.row].description
        cell.textLabel?.text = label
        


        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected")
    }
    

    // Override to support editing the table view.
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            // Delete the row from the data source
//            tableView.deleteRows(at: [indexPath], with: .fade)
//
//        }
//    }
    
    func load() {
        db.collection("users").getDocuments() {(querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                
                for document in querySnapshot!.documents {
                    
                    
                    let data = document.data()
                    
                    self.userArray.append(data)
                    
                    
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
 

  

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }


}
