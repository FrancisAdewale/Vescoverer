//
//  VeganViewController.swift
//  Ve-scoverer
//
//  Created by Francis Adewale on 17/12/2020.
//

import UIKit
import RealmSwift

 

class VeganViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    let realm = try! Realm()
    var userVeganSince = NormalUser()

    
    var selectedRow = ""
    var currentuser = ""


    @IBOutlet weak var veganSince: UIPickerView!
    
    @IBOutlet weak var veganQuestion: UILabel!
    let times = ["<20 years","<10 years","<5 years","<2 years", "<1 year", "<6 months" ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        veganSince.dataSource = self
        veganSince.delegate = self
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))


    }
    

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return times.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        selectedRow = times[row]
        
        return times[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 50.0
    }
    
    @IBAction func next(_ sender: Any) {
        
        let newUser = RealmUser()
        newUser.veganSince = selectedRow
        userVeganSince.veganSince = selectedRow
        
        // Updating book with id = 1
//        try! realm.write {
//            realm.add(newUser, update: .modified)
//        }
//        
//        do {//commit changes to realm db
//            try realm.write{
//                realm.add(newUser)
//            }
//        } catch {
//            print("Error \(error)")
//        }
        
        
    
        let nvc = storyboard?.instantiateViewController(withIdentifier: "Name") as! NameViewController
        
        nvc.modalPresentationStyle = .overFullScreen
        
        present(nvc, animated: false, completion: nil)
        
    }
    
}
