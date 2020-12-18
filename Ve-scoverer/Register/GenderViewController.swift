//
//  GenderViewController.swift
//  Ve-scoverer
//
//  Created by Francis Adewale on 18/12/2020.
//

import UIKit

class GenderViewController: UIViewController,  UIPickerViewDataSource, UIPickerViewDelegate{
    
    @IBOutlet weak var genderPicker: UIPickerView!
    
    let gender = ["male","female","transgender"]

    override func viewDidLoad() {
        super.viewDidLoad()
        genderPicker.delegate = self
        genderPicker.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return gender.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return gender[row]
    }
    

 

}
