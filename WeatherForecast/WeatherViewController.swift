//
//  ViewController.swift
//  WeatherForecast
//
//  Created by Junhee Yoon on 2022/08/13.
//

import UIKit

class WeatherViewController: UIViewController {

    // MARK: - Properties
    
    var locationData: [LocationData] = []
    var weatherData: [WeatherData] = []
    
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchingData()
    }
    
    
    // MARK: - Networking
    
    func fetchingData() {
        FetchLocationInfo.shared.fetchingLocationData(query: "부산") { locData in
            
            self.locationData.append(locData)
            
            FetchWeatherInfo.shared.fetchingWeatherData(latitudes: locData.latitude, longitudes: locData.longitude) { weathData in
                
                self.weatherData.append(weathData)
                
            }
        }
    }
    
    
    
    
    
    
    
    
    

}

