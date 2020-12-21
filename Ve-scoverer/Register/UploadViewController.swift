//
//  UploadViewController.swift
//  Ve-scoverer
//
//  Created by Francis Adewale on 18/12/2020.
//

import UIKit

class UploadViewController: UIViewController,UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    let picker = UIImagePickerController()
    
    

    override func viewDidLoad() {
        
        super.viewDidLoad()
        picker.delegate = self
        picker.allowsEditing = true
        picker.sourceType = .photoLibrary
    }
    

    @IBAction func uploadPressed(_ sender: UIButton) {

        present(picker, animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let userImage = info[.editedImage] as! UIImage
        let jpegImage = userImage.jpegData(compressionQuality: 1.0)
        print(jpegImage?.description)
        dismiss(animated: true, completion: nil)

    }
    
    
    @IBAction func next(_ sender: Any) {
        
        let svc = storyboard?.instantiateViewController(withIdentifier: "Social") as! SocialsViewController
        
        svc.modalPresentationStyle = .overFullScreen
        
        present(svc, animated: false, completion: nil)
        
    }
    
}
