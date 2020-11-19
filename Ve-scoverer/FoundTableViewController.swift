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
    
    let currentUser = Auth.auth().currentUser
    
    var loadUser = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hexString: "8bcdcd")
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
        cell.backgroundColor = UIColor(hexString: "3797A4")
        cell.textLabel?.textColor = UIColor(hexString: "cee397")

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected")
    }
    
    
    func load() {
        
//        if Auth.auth().currentUser != nil {
//            db.collection("users").getDocuments { (querySnapshot, err) in
//                if let err = err {
//                    print("Error getting documents: \(err)")
//                }  else {
//
//                    for document in querySnapshot!.documents {
//                        print(document.data())
//                        //self.userList.append(document.documentID)
//                    }
//                    self.tableView.reloadData()
//
//                }
//            }
//        } else {
//            print("Meh")
//
//        }
        
        

        let user = Auth.auth().currentUser
        
        
        db.collection("users").document((user?.email)!).collection("found").getDocuments { (querySnapshot, err) in
            
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                
                for document in querySnapshot!.documents {
                    print(document.data())
                    self.userList.append(document["userFound"] as! String)
                }
                self.tableView.reloadData()
                
            }
        }
    }
    //        db.collection("users").getDocuments() {(querySnapshot, err) in
//            if let err = err {
//                print("Error getting documents: \(err)")
//            } else {
//
//                for document in querySnapshot!.documents {
//                    print(document.data())
//                    self.userList.append(document.documentID)
//                }
//                self.tableView.reloadData()
//
//            }
        }
    
 
