//
//  ProfileViewController.swift
//  Ve-scoverer
//
//  Created by Francis Adewale on 05/11/2020.
//

import UIKit
import CoreData
import Firebase
import FirebaseStorage

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var editedInstagram = String()
    var editedTwitter = String()
    var editedFacebook = String()
    let picker = UIImagePickerController()
    let storage = Storage.storage()
    

    @IBOutlet weak var isVerified: UIImageView!
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var uploadImage: UIButton!
    @IBOutlet weak var tab: UITabBarItem!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        load()
        let user = Auth.auth().currentUser
        profileName.text = user?.email

        
        if let user = user {
            let verified = user.isEmailVerified
            
            if verified {
                isVerified.image = UIImage(named: "verified")
                
            } else {
//                self.label.text = self.label.text
            }
        
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()


        view.backgroundColor = UIColor(hexString: "8bcdcd")
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        picker.delegate = self
        picker.allowsEditing = true
        picker.sourceType = .photoLibrary
        
        
        
        
    }
    
    @IBAction func uploadImagePressed(_ sender: UIButton) {
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let userImage = info[.editedImage] as! UIImage
        let jpegImage = userImage.jpegData(compressionQuality: 1.0)
            //.pngData()
//        let coreImage = Image(context: context)
//        coreImage.img = pngImage

//        do {
//            try! context.save()
//        }

        let storageRef = storage.reference()

        
        
        // Data in memory
        var data = Data()
        
        let userImagesRef = storageRef.child("recents/userimage.jpg")
        
        data.append(jpegImage!)

        _ = userImagesRef.putData(data, metadata: nil) { (metadata, error) in
          guard let metadata = metadata else {
                return
          }
            _ = metadata.size
          userImagesRef.downloadURL { (url, error) in
            guard url != nil else {
              return
            }
          }
        }
        uploadImage.setImage(userImage, for: .normal)
        dismiss(animated: true, completion: nil)

            

    }
    
    //i need to add social media lnks to USER MODEL.
    
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
    
    
    @IBAction func logOutPressed(_ sender: UIButton) {
        
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch {
            print ("Error signing out: \(error)")
        }
        
        let lvc = storyboard?.instantiateViewController(identifier: "Login") as! LoginViewController
        lvc.modalPresentationStyle = .fullScreen
        present(lvc, animated: true, completion: nil)
    }
    
    
    func load() {
        let storageRef = storage.reference()
        
        let userImagesRef = storageRef.child("recents/userimage.jpg")
        
        userImagesRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
          if let error = error {
            print(error)
          } else {
            // Data for "images/island.jpg" is returned
            let image = UIImage(data: data!)
            
                self.uploadImage.setImage(image, for: .normal)
          

          }
        }
        
//        let fetchRequest = NSFetchRequest<Image>(entityName: "Image")
//
//        do {
//            let result = try? context.fetch(fetchRequest)
//            let image = result?.first?.img
//            if let image = image {
//                let imageButton = UIImage(data: image)
//                uploadImage.setImage(imageButton, for: .normal)
//            }
//
//        } catch {
//            print(error)
//        }
    }
    
}
