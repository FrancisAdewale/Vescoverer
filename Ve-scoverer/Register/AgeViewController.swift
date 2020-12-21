//
//  AgeViewController.swift
//  Ve-scoverer
//
//  Created by Francis Adewale on 17/12/2020.
//

import UIKit
import RealmSwift

class AgeViewController: UIViewController {
    
    var userAge = NormalUser()


    @IBOutlet weak var ageSelector: UIDatePicker!
    @IBOutlet weak var age: UILabel!
    
    lazy var dateFormatter : DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM/yyyy"
            formatter.locale = Locale(identifier: "en_US_POSIX")
            return formatter
        }()
    
    @IBOutlet weak var questionLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        let date = dateFormatter.string(from: ageSelector.date)

        let birthday = dateFormatter.date(from: date)
        let timeInterval = birthday?.timeIntervalSinceNow
        let calculatedAge = abs(Int(timeInterval! / 31556926.0))
        age.text = calculatedAge.description

        
    }
    


    @IBAction func selectedAge(_ sender: UIDatePicker) {
        
        let date = dateFormatter.string(from: sender.date)

        let birthday = dateFormatter.date(from: date)
        let timeInterval = birthday?.timeIntervalSinceNow
        let calculatedAge = abs(Int(timeInterval! / 31556926.0))
        age.text = calculatedAge.description
        
        userAge.age = calculatedAge
        
        if (calculatedAge < 20) {
            questionLabel.text = "Aww, a baby"
        } else if (calculatedAge < 30) {
            questionLabel.text = "Roaring 20's"
        } else if (calculatedAge < 40) {
            questionLabel.text = "You're still young"
        } else if (calculatedAge < 50) {
            questionLabel.text = "Cheer Up"
        } else {
            questionLabel.text = "V-gang!"
        }
        
        
    }
    
    @IBAction func next(_ sender: UIButton) {
        
        let gvc = storyboard?.instantiateViewController(withIdentifier: "Gender") as! GenderViewController
        
        gvc.modalPresentationStyle = .overFullScreen
        
        present(gvc, animated: false, completion: nil)
        
    }
}
