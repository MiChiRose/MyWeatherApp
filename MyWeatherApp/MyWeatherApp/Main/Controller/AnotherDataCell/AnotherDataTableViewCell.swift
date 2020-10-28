//
//  AnotherDataTableViewCell.swift
//  MyWeatherApp
//
//  Created by Yura Menschikov on 10/28/20.
//

import UIKit

class AnotherDataTableViewCell: UITableViewCell {
    
    @IBOutlet var sunriseLabel: UILabel!
    @IBOutlet var sunsetLabel: UILabel!
    @IBOutlet var humidityLabel: UILabel!
    @IBOutlet var windSpeedLabel: UILabel!
    @IBOutlet var visibilityLabel: UILabel!
    @IBOutlet var pressureLabel: UILabel!
    @IBOutlet var uvIndexLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    static let identifier = "AnotherDataTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "AnotherDataTableViewCell", bundle: nil)
    }
    
    func configure(with model: DailyWeatherEntry) {
        self.sunriseLabel.text = "\(model.sunriseTime)"
        self.sunsetLabel.text = "\(model.sunsetTime)"
        self.humidityLabel.text = "\(model.humidity)"
        self.windSpeedLabel.text = "\(model.windSpeed)"
        self.visibilityLabel.text = "\(model.visibility)"
        self.pressureLabel.text = "\(model.pressure)"
        self.uvIndexLabel.text = "\(model.uvIndex)"
    }
    
}
