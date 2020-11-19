//
//  VerifyViewController.swift
//  Ve-scoverer
//
//  Created by Francis Adewale on 05/11/2020.
//

import UIKit
import Firebase


class VerifyViewController : UIViewController {
    
    @IBOutlet weak var progress: UIProgressView!
    
    @IBOutlet weak var label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(hexString: "3797A4")
        
        Auth.auth().currentUser?.sendEmailVerification
                {
                    (error) in
                    if error != nil {
                        print(error!.localizedDescription)
                        return
                    } else {
                        
                        let user = Auth.auth().currentUser
                        
                        if let user = user {
                            let verified = user.isEmailVerified
                            
                            if verified {
                                self.progress.progress = 1.0
                                self.label.text = "All Done!"
                                self.viewWillAppear(true)

                                
                            } else {
                                //alert
                            }
                        
                        }

                       

                    }
                }
        


    }
    

}
