//
//  LocationViewController.swift
//  MyWeatherApp
//
//  Created by Yura Menschikov on 10/28/20.
//

import UIKit
import CoreLocation

//MARK:- CoreLocation
extension ViewController: CLLocationManagerDelegate {
    
    func setupLocation() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if !locations.isEmpty, currentLocation == nil {
            currentLocation = locations.first
            locationManager.startUpdatingLocation()
            requestWeatherForLocation()
        }
    }
    
    func requestWeatherForLocation() {
        guard let currentLocation = currentLocation else { return }
        let longitude = currentLocation.coordinate.longitude
        let latitude = currentLocation.coordinate.latitude
        
        print ("\(longitude) \(latitude)")
        let url = "https://api.darksky.net/forecast/ddcc4ebb2a7c9930b90d9e59bda0ba7a/\(latitude),\(longitude)?units=si&exclude=[flags,minutely]"
        
        URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { [self]data, response, error in
            guard let data = data, error == nil else {
                print("something went wrong")
                return
            }
            
            var json: WeatherResponse?
            do {
                json = try JSONDecoder().decode(WeatherResponse.self, from: data)
            }
            catch {
                print("error: \(error)")
            }
            
            guard let results = json else {
                return
            }
            
            let entries = results.daily.data
            
            self.models.append(contentsOf: entries)
            
            let current = results.currently
            self.current = current
            
            self.hourlyModels = results.hourly.data
            
            self.anotherModels = results.daily.data
            
            DispatchQueue.main.async {
                self.table.reloadData()
                
                self.table.tableHeaderView = self.createTableHeader()
            }
        }).resume()
    }
    
    func createTableHeader() -> UIView {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.width))
        headerView.backgroundColor = getColor(red: 0, green: 196, blue: 255)
        let locationLabel = UILabel(frame: CGRect(x: 10, y: 10, width: view.frame.size.width-20, height: headerView.frame.size.height/5))
        let summaryLabel = UILabel(frame: CGRect(x: 10, y: 20+locationLabel.frame.size.height, width: view.frame.size.width-20, height: headerView.frame.size.height/5))
        let tempLabel = UILabel(frame: CGRect(x: 10, y: 20+locationLabel.frame.size.height+summaryLabel.frame.size.height, width: view.frame.size.width-20, height: headerView.frame.size.height/2))

        headerView.addSubview(locationLabel)
        headerView.addSubview(tempLabel)
        headerView.addSubview(summaryLabel)

        tempLabel.textAlignment = .center
        locationLabel.textAlignment = .center
        summaryLabel.textAlignment = .center
        
        guard let currentWeather = self.current else {
            return UIView()
        }
        
        locationLabel.text = "\(showLocation?.timezone ?? "Current Location")"
        tempLabel.text = "\(currentWeather.temperature)°"
        tempLabel.font = UIFont(name: "Helvetica-Bold", size: 32)
        summaryLabel.text = self.current?.summary
        
        
        return headerView
    }
    
}
