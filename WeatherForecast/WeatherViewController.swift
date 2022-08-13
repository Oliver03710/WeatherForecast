//
//  ViewController.swift
//  WeatherForecast
//
//  Created by Junhee Yoon on 2022/08/13.
//

import UIKit

import Kingfisher

class WeatherViewController: UIViewController {

    // MARK: - Properties
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var decriptionLabel: UILabel!
    
    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var feelslikeLabel: UILabel!
    
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var cloudLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    
    @IBOutlet weak var coverView: UIView!

    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchBar()
    }
    
    
    // MARK: - Helper Functions
    
    func configureSearchBar() {
        searchBar.delegate = self
        searchBar.placeholder = "검색할 도시를 입력하세요."
        searchBar.returnKeyType = .search
        searchBar.showsCancelButton = true
    }
    
    
    // MARK: - Networking
    
    func fetchingData(text: String) {
        FetchLocationInfo.shared.fetchingLocationData(query: text) { locationData in
            
            print(locationData.name)
            
            if locationData.name != "" {
                FetchWeatherInfo.shared.fetchingWeatherData(latitudes: locationData.latitude, longitudes: locationData.longitude) { weatherData in
                    
                    DispatchQueue.main.async {
                        
                        self.cityLabel.text = locationData.name
                        self.decriptionLabel.text = weatherData.description
                        self.currentTempLabel.text = "\(Double(round(weatherData.temp * 10)) / 10)℃"
                        self.feelslikeLabel.text = "\(Double(round(weatherData.feelslike * 10)) / 10)℃"
                        self.iconImageView.kf.setImage(with: URL(string: weatherData.icon))
                        
                        self.humidityLabel.text = "\(weatherData.humidity)%"
                        self.cloudLabel.text = "\(weatherData.clouds)%"
                        self.pressureLabel.text = "\(weatherData.pressure)hPa"
                        self.windSpeedLabel.text = "\(weatherData.windSpped)m/s"
                        self.coverView.isHidden = true
                        
                    }
                }
            } else {
                DispatchQueue.main.async {
                    
                    self.coverView.isHidden = false
                    self.searchBar.placeholder = "검색결과가 없습니다."
                }
            }
            
            
        }
    }
    
    
    // MARK: - IBActions
    
    @IBAction func tapGestureActivated(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
}


// MARK: - Extension: UISearchBarDelegate

extension WeatherViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let text = searchBar.text else { return }
        fetchingData(text: text)
        view.endEditing(true)
        searchBar.text = nil
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
    }

}
