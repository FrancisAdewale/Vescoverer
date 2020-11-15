//
//  ProfileViewController.swift
//  Ve-scoverer
//
//  Created by Francis Adewale on 05/11/2020.
//

import UIKit
import CoreData

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var editedInstagram = String()
    var editedTwitter = String()
    var editedFacebook = String()
    
    let picker = UIImagePickerController()

    @IBOutlet weak var isVerified: UIImageView!
    
    @IBOutlet weak var uploadImage: UIButton!
    
    override func viewDidLoad() {
        
        load()
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        super.viewDidLoad()
        picker.delegate = self
        picker.allowsEditing = true
        picker.sourceType = .photoLibrary
        
    }
    
    @IBAction func uploadImagePressed(_ sender: UIButton) {
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let userImage = info[.editedImage] as! UIImage
        let pngImage = userImage.pngData()
        let coreImage = Image(context: context)
        coreImage.img = pngImage
        
        do {
            try! context.save()
        } 
        
        uploadImage.setImage(userImage, for: .normal)
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func igButtonClick(_ sender: Any) {
        
        var textField = UITextField()
        
        let actionsheet = UIAlertController(title: "Select", message: "", preferredStyle: .actionSheet)
        
        let goAction = UIAlertAction(title: "Go", style: .default) { (action) in
            
            let appURL = URL(string: "instagram://user?username=\(self.editedInstagram)")!
            let application = UIApplication.shared
            
            if application.canOpenURL(appURL) {
                application.open(appURL)
            } else {
                let webURL = URL(string: "https://instagram.com/\(self.editedInstagram)")!
                application.open(webURL)
            }
        }
        
        let editAction = UIAlertAction(title: "Edit", style: .default) { (action) in
            
            let alert = UIAlertController(title: "Edit your @", message: "only the suffix", preferredStyle: .alert)
            
            let action = UIAlertAction(title: "Edit", style: .default) { (action) in
                self.editedInstagram = textField.text!
                
            }
            alert.addTextField { (alertTextField) in
                textField = alertTextField
                
            }
            alert.addAction(action)
            
            self.present(alert, animated: true, completion: nil)
        }
        
        actionsheet.addAction(goAction)
        actionsheet.addAction(editAction)
        
        present(actionsheet, animated: true, completion: nil)
    }
    
    
    @IBAction func twitterButtonClicked(_ sender: Any) {
        
        var textField = UITextField()
        
        let actionsheet = UIAlertController(title: "Select", message: "", preferredStyle: .actionSheet)
        
        let goAction = UIAlertAction(title: "Go", style: .default) { (action) in
            
            let appURL = URL(string: "twitter://user?screen_name=\(self.editedTwitter)")!
            let application = UIApplication.shared
            
            if application.canOpenURL(appURL) {
                application.open(appURL)
            } else{
                let webURL = URL(string: "https://twitter.com/\(self.editedTwitter)")!
                application.open(webURL)
            }
            
         
        }
        
        let editAction = UIAlertAction(title: "Edit", style: .default) { (action) in
            
            let alert = UIAlertController(title: "Edit your @", message: "only the suffix", preferredStyle: .alert)
            
            let action = UIAlertAction(title: "Edit", style: .default) { (action) in
                self.editedTwitter = textField.text!
                
            }
            alert.addTextField { (alertTextField) in
                textField = alertTextField
                
            }
            alert.addAction(action)
            
            self.present(alert, animated: true, completion: nil)
        }
        
        actionsheet.addAction(goAction)
        actionsheet.addAction(editAction)
        
        present(actionsheet, animated: true, completion: nil)
        
    
    }
    
    @IBAction func fbButtonClick(_ sender: Any) {
        
        var textField = UITextField()
        
        let actionsheet = UIAlertController(title: "Select", message: "", preferredStyle: .actionSheet)
        
        let goAction = UIAlertAction(title: "Go", style: .default) { (action) in
            
            let appURL = URL(string: "fb://profile/\(self.editedFacebook)")!
            let application = UIApplication.shared
            
            if application.canOpenURL(appURL) {
                application.open(appURL)
            }else{
                let webURL = URL(string: "https://www.facebook.com/\(self.editedFacebook)")!
                application.open(webURL)
            }
            
         
        }
        
        let editAction = UIAlertAction(title: "Edit", style: .default) { (action) in
            
            let alert = UIAlertController(title: "Edit your @", message: "only the suffix", preferredStyle: .alert)
            
            let action = UIAlertAction(title: "Edit", style: .default) { (action) in
                self.editedFacebook = textField.text!
                
            }
            alert.addTextField { (alertTextField) in
                textField = alertTextField
                
            }
            alert.addAction(action)
            
            self.present(alert, animated: true, completion: nil)
        }
        
        actionsheet.addAction(goAction)
        actionsheet.addAction(editAction)
        
        present(actionsheet, animated: true, completion: nil)
        
    }
    
    func load() {
        let fetchRequest = NSFetchRequest<Image>(entityName: "Image")
        
        do {
            let result = try? context.fetch(fetchRequest)
            let image = result?.first?.img
            if let image = image {
                let imageButton = UIImage(data: image)
                uploadImage.setImage(imageButton, for: .normal)
            }
            
        } catch {
            print(error)
        }
    }
    
}
