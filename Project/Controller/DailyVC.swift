//
//  DailyVC.swift
//  Project
//
//  Created by comviva on 17/02/22.
//

import UIKit

class DailyVC: UIViewController {

    @IBOutlet weak var table: UITableView!
    
    @IBOutlet weak var temperatureType: UISegmentedControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        table.delegate = self
        table.dataSource = self
        
        //design table
        table.separatorStyle = .none
        table.showsVerticalScrollIndicator = false
    }
    
}


extension DailyVC : UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}

extension DailyVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "daily", for: indexPath) as! DailyTVC
        //cell.iconL.image = UIImage(named: "person")
        cell.HumidityLabel.text = "Humidity : 80%"
        cell.MaxTempLabel.text = "Max Temp : 35° C"
        cell.MinTempLabel.text = "Min Temp : 25° C"
        cell.dateLabel.text = "Wed, Feb, 18"
        cell.WindSpeedLabel.text = "Wind Speed : 5.32"
        cell.descriptionLabel.text = "light rain"
        
        
        return cell
    }
}
