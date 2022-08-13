//
//  FetchWeatherInfo.swift
//  WeatherForecast
//
//  Created by Junhee Yoon on 2022/08/13.
//

import Foundation

import Alamofire
import SwiftyJSON

class FetchWeatherInfo {
    
    private init() { }
    
    static let shared = FetchWeatherInfo()
    
    typealias completionHandler = (WeatherData) -> Void
    
    func fetchingWeatherData(latitudes: Double, longitudes: Double, completionHandler: @escaping completionHandler) {
        
        let url = EndPoints.weatherURL + "?lat=\(latitudes)&lon=\(longitudes)&appid=\(APIKeys.weatherAPI)&lang=kr"
        
        AF.request(url, method: .get).validate(statusCode: 200...500).responseData(queue: .global()) { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)

                let description = json["weather"][0]["description"].stringValue
                let icon = json["weather"][0]["icon"].stringValue + "@2x.png"
                let main = json["weather"][0]["main"].stringValue
                let temp = json["main"]["temp"].doubleValue - 273.15
                let feelslike = json["main"]["feels_like"].doubleValue - 273.15
                let pressure = json["main"]["pressure"].intValue
                let humidity = json["main"]["humidity"].intValue
                let windSpped = json["wind"]["speed"].doubleValue
                let clouds = json["clouds"]["all"].intValue
                
                let data = WeatherData(main: main, description: description, icon: icon, temp: temp, feelslike: feelslike, pressure: pressure, humidity: humidity, windSpped: windSpped, clouds: clouds)
                
                completionHandler(data)
                
            case .failure(let error):
                print(error)
            }
        }
    }

}
