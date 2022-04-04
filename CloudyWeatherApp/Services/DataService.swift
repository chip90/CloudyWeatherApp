//
//  DataService.swift
//  CloudyWeatherApp
//
//  Created by Carleton C Snow III on 2/20/22.
//

import Foundation

protocol DataServiceDelegate: AnyObject {
    func weatherDidUpdate()
}

class DataService {
    
    static let instance = DataService()
        
    public private(set) var hourly = Array<HourlyWeather>()
    public private(set) var daily = Array<DailyWeather>()
    public private(set) var current_dt: String?
    public private(set) var cityName: String?
    public private(set) var weatherDescription: String?
    public private(set) var current_temp: String?
    public private(set) var imageNmae: String?
    
    var lat: Double = 0.0
    var lon: Double = 0.0
    
    weak var delegate: DataServiceDelegate?
    
    func getLocation() {
        LocationService.shared.getLocation()
    }

    func getWeather() {
        NetworkService.shared.getCurrentWeather(lat: lat, lon: lon) { [weak self] result in
            switch result {
            case .success(let weatherdata):
                self?.hourly = weatherdata.hourly
                self?.daily = weatherdata.daily
                self?.current_dt = self?.dateFormatting(value: weatherdata.current.dt)
                self?.weatherDescription = weatherdata.current.weather.first?.description
                self?.current_temp = self?.tempConvert(temp: weatherdata.current.temp)
                self?.imageNmae = weatherdata.current.weather.first?.icon
                self?.delegate?.weatherDidUpdate()
            case .failure(let error):
                print("Weather Error: \(error)")
            }
        }
        
    }
    
    func getCityName() {
        NetworkService.shared.getCurrentCityName(lat: lat, lon: lon) { [weak self] result in
            switch result {
            case .success(let cityNameData):
                self?.cityName = cityNameData.first?.name
                self?.delegate?.weatherDidUpdate()
                print(cityNameData)
            case .failure(let error):
                print("City Name Error: \(error)")
            }
        }
    }
    
    func getImageName(icon: String) -> String {
        if icon == "01d" || icon == "01n" {
            return "Sunny"
        }
        if icon == "02d" || icon == "02n" {
            return "PartiallyCloudy"
        }
        if icon == "03d" || icon == "03n" || icon == "04d" || icon == "04n" {
            return "Cloudy"
        }
        if icon == "09d" || icon == "09n" || icon == "10d" || icon == "10n" {
            return "Rainy"
        }
        if icon == "11d" || icon == "11n" {
            return "Rainy"
        }
        if icon == "13d" || icon == "13n" {
            return "Snow"
        }
        
        return ""
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
