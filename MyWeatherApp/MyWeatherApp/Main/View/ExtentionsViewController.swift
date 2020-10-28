//
//  ExtentionsViewController.swift
//  MyWeatherApp
//
//  Created by Yura Menschikov on 10/28/20.
//

import UIKit

//MARK:- TableView
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func createTable() {
        table.delegate = self
        table.dataSource = self
        table.register(WeatherTableViewCell.nib(), forCellReuseIdentifier: WeatherTableViewCell.identifier)
        table.register(HourlyTableViewCell.nib(), forCellReuseIdentifier: HourlyTableViewCell.identifier)
        table.backgroundColor = getColor(red: 0, green: 196, blue: 255)
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: HourlyTableViewCell.identifier, for: indexPath) as! HourlyTableViewCell
            cell.configure(with: hourlyModels)
            cell.backgroundColor = getColor(red: 0, green: 196, blue: 255)
            return cell
        }
        
        if indexPath.section == indexPath.count{
            let cell = tableView.dequeueReusableCell(withIdentifier: AnotherDataTableViewCell.identifier, for: indexPath) as! AnotherDataTableViewCell
            cell.configure(with: anotherModels[indexPath.row])
            cell.backgroundColor = getColor(red: 0, green: 196, blue: 255)
            return cell
        }
            let cell = tableView.dequeueReusableCell(withIdentifier: WeatherTableViewCell.identifier, for: indexPath) as! WeatherTableViewCell
            cell.configure(with: models[indexPath.row])
            cell.backgroundColor = getColor(red: 0, green: 196, blue: 255)
            return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

//MARK:- Helpers
extension ViewController {
    func showAlert(view: UIViewController, title: String, message: String, completion: @escaping() -> ()) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: {_ in completion()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { _ in}))
        view.present(alert, animated: true, completion: nil)
    }
    
    func getColor(red: Double, green: Double, blue: Double) -> UIColor {
        let color = UIColor(red: CGFloat(red/255.0), green: CGFloat(green/255.0), blue: CGFloat(blue/255.0), alpha: 1.0)
        return color
    }
    
}
