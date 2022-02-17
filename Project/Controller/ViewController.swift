//
//  ViewController.swift
//  Project
//
//  Created by comviva on 17/02/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var enteredCity: UITextField! // city name to be typed
    
    @IBOutlet weak var pickedCity: UITextField! // city name to be picked
    
    @IBOutlet weak var yourCity: UILabel!// your picked or typed city
    
    
    //list of city in picker
    let cityPicks = ["Bhubaneswar", "Mumbai", "Delhi", "Bangalore", "Ahmedabad", "Chennai", "Kolkata", "Hyderabad", "Pune", "Surat", "Jaipur", "Lucknow", "Bhopal", "Thane"]
    var pickerView = UIPickerView()
    
    
    let lUtility = LocationManager.instance // instance of LocationManager

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        enteredCity.delegate = self
        
        //for pickerview
        pickerView.delegate = self
        pickerView.dataSource = self
        pickedCity.inputView = pickerView
    }

    @IBAction func getLocationClicked(_ sender: Any) {
        if lUtility.startTracking() {
            print("Tracking Started")
            updateInfo()
        }
        else {
            print("Check permission")
        }
    }
    
    func updateInfo() {
        lUtility.getCurrentAddress { (addr) in
            print("Current Address: \(addr)")
            //self.ct = addr
            self.yourCity.text = "Your City : \(addr)"
        }
    }
    
}


//extension for pickeview
extension ViewController : UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cityPicks.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return cityPicks[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickedCity.text = cityPicks[row]
        yourCity.text = "Your city : \(cityPicks[row])"
        //ct = cityPicks[row]
        pickedCity.resignFirstResponder()
    }
}

//textfield delegate
extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        enteredCity.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Enter Your City"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = enteredCity.text {
            yourCity.text = "Your city : \(city)"
//            ct = city
        }
        enteredCity.text = ""
    }
}
