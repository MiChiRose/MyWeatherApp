//
//  ViewController.swift
//  MyWeatherApp
//
//  Created by Yura Menschikov on 10/27/20.
//

import UIKit
import CoreLocation

final class ViewController: UIViewController{
    
    @IBOutlet var table: UITableView!
    internal var models = [DailyWeatherEntry]()
    internal var hourlyModels = [HourlyWeatherEntry]()
    internal var anotherModels = [DailyWeatherEntry]()

    internal let locationManager = CLLocationManager()
    internal var currentLocation: CLLocation?
    internal var current: CurrentWeather?
    internal var showLocation: WeatherResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = getColor(red: 0, green: 196, blue: 255)
        createTable()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super .viewDidAppear(animated)
        setupLocation()
    }
    
}

