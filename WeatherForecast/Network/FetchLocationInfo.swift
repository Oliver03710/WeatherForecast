//
//  FetchLocationInfo.swift
//  WeatherForecast
//
//  Created by Junhee Yoon on 2022/08/13.
//

import Foundation

import Alamofire
import SwiftyJSON

class FetchLocationInfo {
    
    private init() { }
    
    static let shared = FetchLocationInfo()
    
    typealias completionHandler = (LocationData) -> Void
    
    func fetchingLocationData(query: String, completionHandler: @escaping completionHandler) {
        
        guard let text = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        let url = EndPoints.locationURL + "?q=\(text)&appid=\(APIKeys.weatherAPI)"
        
        AF.request(url, method: .get).validate(statusCode: 200...400).responseData(queue: .global()) { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)

                let name = json[0]["local_names"]["ko"].stringValue
                let latitude = json[0]["lat"].doubleValue
                let longitude = json[0]["lon"].doubleValue
                
                let locationData = LocationData(name: name, latitude: latitude, longitude: longitude)
                
                completionHandler(locationData)
                
            case .failure(let error):
                print(error)
            }
        }
    }

}
