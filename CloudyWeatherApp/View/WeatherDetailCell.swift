//
//  WeatherDetailCell.swift
//  CloudyWeatherApp
//
//  Created by Carleton C Snow III on 2/20/22.
//

import UIKit

class WeatherDetailCell: UICollectionViewCell {
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var imgWeather: UIImageView!
    @IBOutlet weak var lblTemp: UILabel!
    
    func dateFormatting(value: TimeInterval) -> String {
        let date = NSDate(timeIntervalSince1970: value)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        
        let dateText = dateFormatter.string(from: date as Date)
        return dateText
        
    }
    
    func tempConvert(temp: Double) -> String {
        let newTemp = (temp - 273.15) * 9 / 5 + 32
        let roundedTemp = round(newTemp)
        return String(roundedTemp)
    }
    
    func updateView(day: DailyWeather) {
        lblDate.text = dateFormatting(value: day.dt)
        lblTemp.text = tempConvert(temp: day.temp.day)
    }
}
