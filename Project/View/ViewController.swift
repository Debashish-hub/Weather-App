//
//  ViewController.swift
//  Project
//
//  Created by comviva on 17/02/22.
//

import UIKit
import LocationFound

class ViewController: UIViewController {

    @IBOutlet weak var enteredCity: UITextField! // city name to be typed
    
    @IBOutlet weak var pickedCity: UITextField! // city name to be picked
    
    @IBOutlet weak var yourCity: UILabel!// your picked or typed city
    
    @IBOutlet weak var checkWeatherBtn: UIButton! //Button
    
    //list of city in picker
    let cityPicks = ["Bhubaneswar", "Mumbai", "Delhi", "Bangalore", "Ahmedabad", "Chennai", "Kolkata", "Hyderabad", "Pune", "Surat", "Jaipur", "Lucknow", "Bhopal", "Thane"]
    var pickerView = UIPickerView()
    
    
    //let lUtility = LocationManager.instance // instance of LocationManager
    let lUtility = LocationFound.LocationManager() //getting from framework
    
    //city name to be enterd or picked or located
    var ChoosenCity = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //background image
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "H2")
        backgroundImage.contentMode = .scaleAspectFill
        view.insertSubview(backgroundImage, at: 0)
        
        //making the button inviseble initially, button will be visible after entering city
        checkWeatherBtn.isEnabled = false
        
        //textfield
        enteredCity.delegate = self
        
        //for pickerview
        pickerView.delegate = self
        pickerView.dataSource = self
        pickedCity.inputView = pickerView
    }
    
    //passing value of city
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let wVC = segue.destination as! WeatherTodayVC
        wVC.city = ChoosenCity
    }

    //getting location details
    @IBAction func getLocationClicked(_ sender: Any) {
        if lUtility.startTracking() {
            print("Tracking Started")
            updateInfo()
            checkWeatherBtn.isEnabled = true
        }
        else {
            print("Check permission")
        }
    }
    
    //updating location and label
    func updateInfo() {
        lUtility.getCurrentAddress { (addr) in
            print("Current Address: \(addr)")
            self.ChoosenCity = addr
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
        checkWeatherBtn.isEnabled = true
        yourCity.text = "Your city : \(cityPicks[row])"
        ChoosenCity = cityPicks[row]
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
            textField.placeholder = "Enter City"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = enteredCity.text {
            checkWeatherBtn.isEnabled = true
            yourCity.text = "Your city : \(city.capitalized)"
            self.ChoosenCity = city.capitalized
        }
        enteredCity.text = ""
    }
}
