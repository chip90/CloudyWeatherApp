//
//  NetworkService.swift
//  CloudyWeatherApp
//
//  Created by Carleton C Snow III on 2/19/22.
//

import Foundation

class NetworkService {
    static let shared = NetworkService()
    
    let session = URLSession(configuration: .default)
    
    func getCurrentWeather(lat: Double, lon: Double, onSuccess:  @escaping (WeatherData) -> Void, onError: @escaping (String) -> Void) {
        
        let exclude = "minutely"
        let apiKey = "65fa0a6c945f630a7628c3c99437015a"
        let URL_BASE = "https://api.openweathermap.org/data/2.5/onecall?"
        
        let url = URL(string: "\(URL_BASE)lat=\(lat)&lon=\(lon)&exclude=\(exclude)&appid=\(apiKey)")!
        print(url)
        let task = session.dataTask(with: url) { (data, response, error) in
            
            DispatchQueue.main.async {
                if let error = error {
                    onError(error.localizedDescription)
                    return
                }
                
                guard let data = data, let response = response as? HTTPURLResponse else {
                    onError("Invalid data or response")
                    return
                }
                
                do {
                    if response.statusCode == 200 {
                        let current = try JSONDecoder().decode(WeatherData.self, from: data)
                        onSuccess(current)
                    } else {
                        let err = try JSONDecoder().decode(APIError.self, from: data)
                        onError(err.message)
                    }
                } catch {
                    onError(error.localizedDescription)
                }
            }
        }
        task.resume()
    }
}
