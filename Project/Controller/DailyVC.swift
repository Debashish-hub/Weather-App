//
//  DailyVC.swift
//  Project
//
//  Created by comviva on 17/02/22.
//

import UIKit

class DailyVC: UIViewController {

    @IBOutlet weak var table: UITableView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var dailyL: UILabel!
    
    @IBOutlet weak var temperatureType: UISegmentedControl!
    
    var dailyList : [DailyResult] = []
    
    var lat = 0.0
    var lon = 0.0
    var city = ""
    var celsius = true
    var LDate = weatherUtility()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        DispatchQueue.main.asyncAfter(deadline: .now()+1){
            self.activityIndicator.stopAnimating()
            self.table.isHidden = false
            self.dailyL.isHidden = false
            self.temperatureType.isHidden = false
        }
        
        
        table.delegate = self
        table.dataSource = self
        
        //design table
        table.separatorColor = .blue
        table.showsVerticalScrollIndicator = false
        
        AFUtility.instance.getDailyForecast(Lat: lat, Long: lon) { data in
            self.dailyList = data.daily
            self.table.reloadData()
        }
        print(lat)
        print(lon)
    }
    
    @IBAction func temperatureType(_ sender: Any) {
        switch temperatureType.selectedSegmentIndex{
        case 1:
            celsius = false
            
        default:
            celsius = true
        }
        table.reloadData()
    }
    
    
}


extension DailyVC : UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}

extension DailyVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dailyList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "daily", for: indexPath) as! DailyTVC
        
        
        let std = dailyList[indexPath.row]
        if celsius {
            cell.MinTempLabel.text = "Min Temp : \(std.temp.min) \u{00B0}C"
            cell.MaxTempLabel.text = "Max Temp : \(std.temp.max) \u{00B0}C"
            
        }else{
            cell.MinTempLabel.text = "Min Temp : \(Float(std.temp.min * 1.8 + 32))\u{00B0} F"
            cell.MaxTempLabel.text = "Max Temp : \(Float(std.temp.min * 1.8 + 32))\u{00B0} F"
            
        }
        
        cell.dateLabel.text = "\(LDate.getDate(dt: std.dt))"
        cell.WindSpeedLabel.text = "Wind Speed : \(std.wind_speed) m/s"
        cell.descriptionLabel.text = std.weather[0].description.capitalized
        cell.HumidityLabel.text = "Humidity : \(std.humidity)"
        
        let imgURL = "http://openweathermap.org/img/wn/\(std.weather[0].icon)@2x.png"
        AFUtility.instance.downloadImage(imgURL: imgURL) { (imgData) in
            cell.iconL.image = UIImage(data: imgData)
        }
        return cell
    }
}
