//
//  HourlyVC.swift
//  Project
//
//  Created by comviva on 17/02/22.
//

import UIKit

class HourlyVC: UIViewController {

    @IBOutlet weak var table: UITableView!

    @IBOutlet weak var temperatureType: UISegmentedControl!
    
    var hourlyList : [HourlyResult] = []
    
    var lat = 0.0
    var lon = 0.0
    
    var LDate = weatherUtility()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        table.delegate = self
        table.dataSource = self
        
        //design table
        table.separatorStyle = .none
        table.showsVerticalScrollIndicator = false
        
        
        AFUtility.instance.getHourlyData(Lat: lat, Long: lon) { data in
            self.hourlyList = data.hourly
            self.table.reloadData()
        }
        print("currentLat:\(lat)")
        print("currentLong:\(lon)")
    }
    


}

extension HourlyVC : UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}

extension HourlyVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hourlyList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "hourly", for: indexPath) as! HourlyTVC
        
        
        let std = hourlyList[indexPath.row]
        cell.maxTemperature.text = "Temperature : \(std.temp) \u{00B0}C"
        cell.timeLabel.text = "\(LDate.getTime(dt: std.dt))"
        cell.windspeedLabel.text = "Wind Speed : \(std.wind_speed) "
        cell.descriptionLabel.text = std.weather.description
        cell.humidityLabel.text = "Humidity : \(std.humidity)"
        //cell.iconL.image = UIImage(named: "person")
//        cell.humidityLabel.text = "Humidity : 80%"
//        cell.maxTemperature.text = "Temp : 35° C"
//        cell.timeLabel.text = "07.30 PM"
//        cell.windspeedLabel.text = "Wind Speed : 5.32"
//        cell.descriptionLabel.text = "light rain"
        
        
        return cell
    }
}
