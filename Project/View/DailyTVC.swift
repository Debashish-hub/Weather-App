//
//  DailyTVC.swift
//  Project
//
//  Created by comviva on 17/02/22.
//

import UIKit

class DailyTVC: UITableViewCell {

    
    @IBOutlet weak var bgView: UIView!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var iconL: UIImageView!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var MaxTempLabel: UILabel!
    
    @IBOutlet weak var MinTempLabel: UILabel!
    
    @IBOutlet weak var HumidityLabel: UILabel!
    
    @IBOutlet weak var WindSpeedLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
