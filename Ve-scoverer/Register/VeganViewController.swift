//
//  VeganViewController.swift
//  Ve-scoverer
//
//  Created by Francis Adewale on 17/12/2020.
//

import UIKit

class VeganViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
   

    @IBOutlet weak var veganSince: UIPickerView!
    
    @IBOutlet weak var veganQuestion: UILabel!
    let times = ["<20 years","<10 years","<5 years","<2 years", "<1 year", "<6 months" ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        veganSince.dataSource = self
        veganSince.delegate = self
        
        
    }
    

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return times.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return times[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 50.0
    }
    
    @IBAction func next(_ sender: Any) {
        let nvc = storyboard?.instantiateViewController(withIdentifier: "Name") as! NameViewController
        
        nvc.modalPresentationStyle = .overFullScreen
        
        present(nvc, animated: false, completion: nil)
        
    }
    
}
