//
//  WeatherData.swift
//  WeatherForecast
//
//  Created by Junhee Yoon on 2022/08/13.
//

import Foundation

struct WeatherData {
    
    let main: String
    let description: String
    let icon: String
    let temp: Double
    let feelslike: Double
    let pressure: Int
    let humidity: Int
    let windSpped: Double
    let clouds: Int
    
}

struct LocationData {
    
    let name: String
    let latitude: Double
    let longitude: Double

}
