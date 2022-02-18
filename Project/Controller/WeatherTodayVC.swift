//
//  WeatherTodayVC.swift
//  Project
//
//  Created by comviva on 17/02/22.
//

import UIKit

class WeatherTodayVC: UIViewController {

    
    @IBOutlet weak var dateLabel: UILabel! // date
    
    @IBOutlet weak var placeLabel: UILabel! //place
    
    @IBOutlet weak var iconLabel: UIImageView! //icon
    
    @IBOutlet weak var temperatureLabel: UILabel! //temperature
    
    @IBOutlet weak var temperatureType: UISegmentedControl! //celcius or kelvin
    
    @IBOutlet weak var sunriseLabel: UILabel! //sunrise
    
    @IBOutlet weak var sunsetLabel: UILabel! //sunset
    
    var city = ""
    let lUtility = LocationManager.instance // instance of LocationManager
    var lat = 0.0
    var lon = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        placeLabel.text = city
        lUtility.getGeoCoord(address: city) { (loc) in
            self.lat = loc.coordinate.latitude
            self.lon = loc.coordinate.longitude
        }
        print("Latitude : \(lat)")
        print("Longitude : \(lon)")
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
