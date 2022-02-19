//
//  HourlyVC.swift
//  Project
//
//  Created by comviva on 17/02/22.
//

import UIKit

class HourlyVC: UIViewController {

    @IBOutlet weak var table: UITableView!

    @IBOutlet weak var hourlyL: UILabel!
    
    @IBOutlet weak var temperatureType: UISegmentedControl!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var hourlyList : [HourlyResult] = []
    
    var lat = 0.0
    var lon = 0.0
    
    var celsius = true
    
    var LDate = weatherUtility()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        DispatchQueue.main.asyncAfter(deadline: .now()+1){
            self.activityIndicator.stopAnimating()
            self.table.isHidden = false
            self.hourlyL.isHidden = false
            self.temperatureType.isHidden = false
        }
        
        table.delegate = self
        table.dataSource = self
        
        //design table
        table.separatorColor = .blue
        table.showsVerticalScrollIndicator = false
        
        
        AFUtility.instance.getHourlyData(Lat: lat, Long: lon) { data in
            self.hourlyList = data.hourly
            self.table.reloadData()
        }
        //background image
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "Night")
        backgroundImage.contentMode = .scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
    }
    
    @IBAction func temperaturePicker(_ sender: Any) {
        switch temperatureType.selectedSegmentIndex{
        case 1:
            celsius = false
            
        default:
            celsius = true
        }
        table.reloadData()
    }
    

}

extension HourlyVC : UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
}

extension HourlyVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hourlyList.count - 24
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "hourly", for: indexPath) as! HourlyTVC
        
        
        let std = hourlyList[indexPath.row]
        if celsius{
            cell.maxTemperature.text = "Temp : \(std.temp) \u{00B0} C"
        }else{
            cell.maxTemperature.text = "Temp : \(Float(std.temp * 1.8 + 32)) \u{00B0} F"
        }
        
        cell.timeLabel.text = "\(LDate.getTime(dt: std.dt))"
        cell.windspeedLabel.text = "Wind Speed : \(std.wind_speed) m/s"
        cell.descriptionLabel.text = std.weather[0].description.capitalized
        cell.humidityLabel.text = "Humidity : \(std.humidity)"
        
        let imgURL = "http://openweathermap.org/img/wn/\(std.weather[0].icon)@2x.png"
        AFUtility.instance.downloadImage(imgURL: imgURL) { (imgData) in
            cell.iconLabel.image = UIImage(data: imgData)
        }
        
        return cell
    }
}
