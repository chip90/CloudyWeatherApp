//
//  WeatherData.swift
//  CloudyWeatherApp
//
//  Created by Carleton C Snow III on 2/19/22.
//

import Foundation

struct WeatherData: Codable {
    let lat: Double
    let lon: Double
    let timezone: String
    let current: Currently
    let hourly: Array<HourlyWeather>
    let daily: Array<DailyWeather>
}

struct Currently: Codable {
    let dt: TimeInterval
    let sunrise: TimeInterval
    let sunset: TimeInterval
    let temp: Double
    let feels_like: Double
    let pressure: Int
    let dew_point: Double
    let uvi: Double
    let clouds: Int
    let visibility: Int
    let wind_speed: Double
    let wind_deg: Double
    let weather: Array<Weatherly>
}

struct HourlyWeather: Codable {
    let dt: TimeInterval
    let temp: Double
    let feels_like: Double
    let pressure: Int
    let humidity: Int
    let uvi: Double
    let clouds: Int
    let visibility: Int
    let wind_speed: Double
    let wind_deg: Double
    let wind_gust: Double
    let weather: Array<Weatherly>
    let pop: Double
}

struct DailyWeather: Codable {
    let dt: TimeInterval
    let sunrise: TimeInterval
    let sunset: TimeInterval
    let moonrise: TimeInterval
    let moonset: TimeInterval
    let moon_phase: Double
    let temp: Temps
    let feels_like: FeelsLike
    let pressure: Int
    let humidity: Int
    let dew_point: Double
    let wind_speed: Double
    let wind_deg: Int
    let wind_gust: Double
    let weather: Array<Weatherly>
    let clouds: Double
    let pop: Double
    let uvi: Double
}

struct Weatherly: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct Temps: Codable {
    let day: Double
    let min: Double
    let max: Double
    let night: Double
    let eve: Double
    let morn: Double
}

struct FeelsLike: Codable {
    let day: Double
    let night: Double
    let eve: Double
    let morn: Double
}
