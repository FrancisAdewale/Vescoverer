//
//  ViewController.swift
//  Ve-scoverer
//
//  Created by Francis Adewale on 03/11/2020.
//

import UIKit
import Firebase
import CoreData

class HomeViewController: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var vegan: [UserCore] = []
    
    
    let db = Firestore.firestore()

    
    @IBOutlet private weak var isVegan: UISwitch! // may need coredata
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        load()
        
        let lvc = storyboard?.instantiateViewController(withIdentifier: "Login")
        
        if vegan.count > 0 {
            lvc!.modalPresentationStyle = .fullScreen
            present(lvc!, animated: true, completion: nil)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Ve-scoverer"
        isVegan.isOn = false
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
    }
    
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        let userEntity = UserCore(context: context) // might add username and password here
    
        if isVegan.isOn {
            userEntity.vegan = isVegan.isOn
            vegan.append(userEntity)
            save()
            return true
        }
        return false
    }
    
    func save() {
        do {
            try context.save()
        } catch {
            print("Could not save \(error)")
        }
    }
    
    func load() {
        let fetch = NSFetchRequest<UserCore>(entityName: "UserCore")
        do {
            let request  = try context.fetch(fetch)
            vegan = request
        } catch {
            print("Could not fetch \(error)")
        }
    }
}

