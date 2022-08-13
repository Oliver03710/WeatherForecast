//
//  ReuseIdentifier+Protocol.swift
//  WeatherForecast
//
//  Created by Junhee Yoon on 2022/08/13.
//

import Foundation
import UIKit

protocol ReuseIdentifierProtocol {
    static var reuseIdentifier: String { get }
}

extension UIViewController: ReuseIdentifierProtocol {
    static var reuseIdentifier: String {
        return String(describing: self)
    }}
