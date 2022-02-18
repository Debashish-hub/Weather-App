//
//  WeatherTodayVC.swift
//  Project
//
//  Created by comviva on 17/02/22.
//

import UIKit

class WeatherTodayVC: UIViewController {
    
    
    @IBOutlet weak var hrBtn: UIButton!
    
    @IBOutlet weak var dlBtn: UIButton!
    
    @IBOutlet weak var todayL: UILabel!
    
    @IBOutlet weak var activityWheel: UIActivityIndicatorView!
    
    @IBOutlet weak var dateLabel: UILabel! // date
    
    @IBOutlet weak var placeLabel: UILabel! //place
    
    @IBOutlet weak var tempPick: UISegmentedControl!
    
    @IBOutlet weak var temperatureL: UILabel!
    
    @IBOutlet weak var iconLabel: UIImageView! //icon
    
    @IBOutlet weak var descL: UILabel!
    
    @IBOutlet weak var sunriseLabel: UILabel! //sunrise
    
    @IBOutlet weak var sunsetLabel: UILabel! //sunset
    
    var LDate = weatherUtility()
    
    var today : Current?
    
    var city = ""
    let lUtility = LocationManager.instance // instance of LocationManager
    var lat = 0.0
    var lon = 0.0
    let d = DailyVC()
    let h = HourlyVC()
    
    var temp = 0.0
    var fahrenheit : Float = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        
        DispatchQueue.main.asyncAfter(deadline: .now()+2){
            self.activityWheel.stopAnimating()
            self.dateLabel.isHidden = false
            self.placeLabel.isHidden = false
            self.tempPick.isHidden = false
            self.temperatureL.isHidden = false
            self.iconLabel.isHidden = false
            self.descL.isHidden = false
            self.sunsetLabel.isHidden = false
            self.sunriseLabel.isHidden = false
            self.hrBtn.isHidden = false
            self.dlBtn.isHidden = false
            self.todayL.isHidden = false
        }
        
        placeLabel.text = city
        lUtility.getGeoCoord(address: city) { (loc) in
            self.lat = loc.coordinate.latitude
            self.lon = loc.coordinate.longitude
            AFUtility.instance.getToday(Lat: self.lat, Long: self.lon) { [self] (Data) in
                self.today = Data.current
                self.descL.text = self.today?.weather[0].description.capitalized
                self.temperatureL.text = "\(self.today?.temp ?? 0.0)\u{00B0}C"
                self.temp = self.today?.temp ?? 0.0
                fahrenheit = Float(temp * 1.8 + 32)
                self.sunsetLabel.text = "Sunset : \(self.LDate.sunTime(time: self.today?.sunset ?? 0.0))"
                self.sunriseLabel.text = "Sunrise : \(self.LDate.sunTime(time: self.today?.sunrise ?? 0.0))"
                self.dateLabel.text = "\(self.LDate.getDate(dt: self.today?.dt ?? 0.0))"
                let imgURL = "http://openweathermap.org/img/wn/\(self.today?.weather[0].icon ?? "50d")@2x.png"
                AFUtility.instance.downloadImage(imgURL: imgURL) { (imgData) in
                    self.iconLabel.image = UIImage(data: imgData)
                }
            }
            
            //self.temperatureLabel.text = "\(today)"
            
        }
        print("Latitude : \(self.lat)")
        print("Longitude : \(self.lon)")
        
        //setting values for daily and hourly updates
        self.d.lat = self.lat
        self.d.lon = self.lon
        self.h.lon = self.lon
        self.h.lat = self.lat
        
        
        //self.temperatureLabel.text = "\(today?.temp ?? 0)"
        
    }
    
    @IBAction func temperaturePicker(_ sender: Any) {
        switch tempPick.selectedSegmentIndex{
        case 1:
            self.temperatureL.text = "\(fahrenheit)\u{00B0} F"
        default:
            self.temperatureL.text = "\(self.today?.temp ?? 0.0)\u{00B0} C"
        }
    }
    
}
