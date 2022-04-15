//
//  ViewController.swift
//  CloudyWeatherApp
//
//  Created by Carleton C Snow III on 2/19/22.
//

import UIKit

class MainVC: UIViewController {
    
    @IBOutlet weak var todayDateLbl: UILabel!
    @IBOutlet weak var locationLbl: UILabel!
    @IBOutlet weak var weatherDescriptionLbl: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var tempLbl: UILabel!
    
    @IBOutlet weak var weatherDetails: UICollectionView!
    
    enum weatherSelector {
        case today, week
    }
    
    var selectedWeather: weatherSelector = .today

    override func viewDidLoad() {
        super.viewDidLoad()
        weatherDetails.dataSource = self
        weatherDetails.delegate = self
        
        DataService.instance.delegate = self
        DataService.instance.getLocation()
    }
    
    @IBAction func todayBtn(_ sender: Any) {
        selectedWeather = .today
        weatherDetails.reloadData()
    }
    
    @IBAction func thisWeekBtn(_ sender: Any) {
        selectedWeather = .week
        weatherDetails.reloadData()
    }
    
}

extension MainVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch selectedWeather {
        case .today:
            return DataService.instance.daily.count
        case .week:
            return DataService.instance.daily.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = weatherDetails.dequeueReusableCell(withReuseIdentifier: "weatherCell", for: indexPath) as! WeatherDetailCell
        
        switch selectedWeather {
        case .today:
            let hour = DataService.instance.hourly[indexPath.row]
            cell.updateHourView(hour: hour)
            return cell
        case .week:
            let day = DataService.instance.daily[indexPath.row]
            cell.updateDayView(day: day)
            return cell
        }
        
        
        
    }
}

extension MainVC: DataServiceDelegate {
    
    func weatherDidUpdate() {
        todayDateLbl.text = DataService.instance.current_dt
        locationLbl.text = DataService.instance.cityName
        weatherDescriptionLbl.text = DataService.instance.weatherDescription
        tempLbl.text = DataService.instance.current_temp
        weatherImage.image = UIImage(named: DataService.instance.getImageName(icon: DataService.instance.imageNmae ?? "Cloudy"))
        weatherDetails.reloadData()
    }
    
    
}

