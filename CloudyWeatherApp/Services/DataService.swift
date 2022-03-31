//
//  DataService.swift
//  CloudyWeatherApp
//
//  Created by Carleton C Snow III on 2/20/22.
//

import Foundation

protocol DataServiceDelegate: AnyObject {
    
}

class DataService {
    
    static let instance = DataService()
        
    public private(set) var hourly = Array<HourlyWeather>()
    public private(set) var daily = Array<DailyWeather>()
    public private(set) var current_dt = ""
    
    var lat: Double = 0.0
    var lon: Double = 0.0
    
    func getLocation() {
        LocationService.shared.getLocation()
    }

    func getWeather() {
        NetworkService.shared.getCurrentWeather(lat: lat, lon: lon) { weatherdata in
            self.hourly = weatherdata.hourly
            self.daily = weatherdata.daily
            self.current_dt = self.dateFormatting(value: weatherdata.current.dt)
            print(self.tempConvert(temp: weatherdata.current.temp))
        } onError: { errorMessage in
            debugPrint(errorMessage)
        }
    }
    
    func dateFormatting(value: TimeInterval) -> String {
        let date = NSDate(timeIntervalSince1970: value)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        dateFormatter.timeStyle = .none
        
        let dateText = dateFormatter.string(from: date as Date)
        return dateText
        
    }
    
    func tempConvert(temp: Double) -> String {
        let newTemp = (temp - 273.15) * 9 / 5 + 32
        let roundedTemp = round(newTemp)
        return String(roundedTemp)
    }
}
