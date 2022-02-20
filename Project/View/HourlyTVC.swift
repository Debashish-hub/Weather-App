//
//  HourlyTVC.swift
//  Project
//
//  Created by comviva on 18/02/22.
//

import UIKit

class HourlyTVC: UITableViewCell {

    @IBOutlet weak var bgView: UIView!
    
    @IBOutlet weak var iconLabel: UIImageView!
    
    @IBOutlet weak var windspeedLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var maxTemperature: UILabel!
        
    @IBOutlet weak var humidityLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
