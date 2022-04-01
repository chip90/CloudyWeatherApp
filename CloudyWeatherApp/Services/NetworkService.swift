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
    
    func getCurrentCityName(lat: Double, lon: Double, completion: @escaping (Result<[City], Error>) -> Void) {
        let apiKey = "65fa0a6c945f630a7628c3c99437015a"
        let URL_BASE = "https://api.openweathermap.org/geo/1.0/reverse?"
        let limit = 5
        
        let url = URL(string: "\(URL_BASE)lat=\(lat)&lon=\(lon)&limit=\(limit)&appid=\(apiKey)")!
        print(url)
        let task = session.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let data = data, let response = response as? HTTPURLResponse else {
                    completion(.failure(NSError(domain: "No Data", code: 422, userInfo: nil)))
                    return
                }
                
                do {
                    if response.statusCode == 200 {
                        let cityName = try JSONDecoder().decode([City].self, from: data)
                        completion(.success(cityName))
                    } else {
                        let err = try JSONDecoder().decode(APIError.self, from: data)
                        completion(.failure(err))
                    }
                } catch {
                    completion(.failure(error))
                }

            }
        }
        task.resume()
    }
    
    func getCurrentWeather(lat: Double, lon: Double, completion: @escaping (Result<WeatherData, Error>) -> Void) {
        
        let exclude = "minutely"
        let apiKey = "65fa0a6c945f630a7628c3c99437015a"
        let URL_BASE = "https://api.openweathermap.org/data/2.5/onecall?"
        
        let url = URL(string: "\(URL_BASE)lat=\(lat)&lon=\(lon)&exclude=\(exclude)&appid=\(apiKey)")!
        print(url)
        let task = session.dataTask(with: url) { (data, response, error) in
            
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let data = data, let response = response as? HTTPURLResponse else {
                    completion(.failure(NSError(domain: "No Data", code: 422, userInfo: nil)))
                    return
                }
                
                do {
                    if response.statusCode == 200 {
                        let current = try JSONDecoder().decode(WeatherData.self, from: data)
                        completion(.success(current))
                    } else {
                        let err = try JSONDecoder().decode(APIError.self, from: data)
                        completion(.failure(err))
                    }
                } catch {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
}

private extension NetworkService {
    
    func makeRequest<T: Codable>(from url: URL, completion: @escaping (Result<T, Error>) -> Void) {
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            self?.decodeData(data, completion: completion)
            
        }.resume()
    }
    
    func decodeData<T: Codable>(_ data: Data?, completion: @escaping (Result<T, Error>) -> Void) {
        
        guard let data = data else {
            completion(.failure(NSError(domain: "No Data", code: 404, userInfo: nil)))
            return
        }
        
        do {
            let result = try JSONDecoder().decode(T.self, from: data)
            completion(.success(result))
        } catch(let error) {
            print("Error decoding:", error)
            completion(.failure(error))
        }
    }
}
