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
    
    func hourFormatting(value: TimeInterval) -> String {
        let date = NSDate(timeIntervalSince1970: value)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .short
        
        let dateText = dateFormatter.string(from: date as Date)
        return dateText
    }
    
    func tempConvert(temp: Double) -> String {
        let newTemp = (temp - 273.15) * 9 / 5 + 32
        let roundedTemp = round(newTemp)
        return String(roundedTemp)
    }
    
    func updateDayView(day: DailyWeather) {
        lblDate.text = dateFormatting(value: day.dt)
        lblTemp.text = "L: " + tempConvert(temp: day.temp.min) + " H: " + tempConvert(temp: day.temp.max)
        imgWeather.image = UIImage(named: DataService.instance.getImageName(icon: day.weather.first?.icon ?? "Cloudy"))
    }
    
    func updateHourView(hour: HourlyWeather) {
        lblDate.text = hourFormatting(value: hour.dt)
        lblTemp.text = tempConvert(temp: hour.temp)
        imgWeather.image = UIImage(named: DataService.instance.getImageName(icon: hour.weather.first?.icon ?? "Cloudy"))
    }
}
