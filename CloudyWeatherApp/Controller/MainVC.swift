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

    override func viewDidLoad() {
        super.viewDidLoad()
        weatherDetails.dataSource = self
        weatherDetails.delegate = self
        
        DataService.instance.delegate = self
        DataService.instance.getLocation()
    }
    
    @IBAction func yesterdayBtn(_ sender: Any) {
    }
    
    @IBAction func todayBtn(_ sender: Any) {
    }
    
    @IBAction func thisWeekBtn(_ sender: Any) {
    }
    
}

extension MainVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return DataService.instance.daily.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = weatherDetails.dequeueReusableCell(withReuseIdentifier: "weatherCell", for: indexPath) as! WeatherDetailCell
        let day = DataService.instance.daily[indexPath.row]
        cell.updateView(day: day)
        return cell
    }
}

extension MainVC: DataServiceDelegate {
    
    func weatherDidUpdate() {
        todayDateLbl.text = DataService.instance.current_dt
        locationLbl.text = DataService.instance.cityName
        weatherDescriptionLbl.text = DataService.instance.weatherDescription
        tempLbl.text = DataService.instance.current_temp
        weatherImage.image = UIImage(named: "Snow")
        weatherDetails.reloadData()
    }
    
    
}

