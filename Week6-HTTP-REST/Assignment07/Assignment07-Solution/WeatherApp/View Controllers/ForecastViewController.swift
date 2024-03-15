//
//  ForecastViewController.swift
//  WeatherApp
//
//  Created by Mohamed Shehab on 3/11/24.
//

import UIKit
import SwiftyJSON
import Alamofire
import PKHUD
import Kingfisher

class ForecastViewController: UIViewController {
    var city : City?
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UINib(nibName: "ForecastTableViewCell", bundle: nil), forCellReuseIdentifier: "ForecastTableViewCell")
        self.title = self.city!.name + ", " + self.city!.state
        
        getForecastUrl()
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    var forecasts = [Forecast]()
    
    
    func getForecastUrl(){
        
        let url = "https://api.weather.gov/points/\(self.city!.lat),\(self.city!.lng)"
        
        print(url)
        
        HUD.show(.labeledProgress(title: "Loading Forecast", subtitle: "Please Wait ..."))
        
        AF.request(url)
            .validate(statusCode: 200..<300)
            .responseData { response in
                switch response.result {
                case .success:
                    if let data = response.data {
                        if let json = try? JSON(data) {
                            let forecastUrl = json["properties"]["forecast"].stringValue
                            self.getForecastDetails(forecastUrl)
                        }
                    }
                    print("Validation Successful")
                case let .failure(error):
                    print(error)
                    HUD.hide()
                }
            }
    }
    
    func getForecastDetails(_ url: String){
    
        
        AF.request(url)
            .validate(statusCode: 200..<300)
            .responseData { response in
                HUD.hide()
                switch response.result {
                case .success:
                    if let data = response.data {
                        if let json = try? JSON(data) {
                            let periodsArray = json["properties"]["periods"].arrayValue
                            
                            self.forecasts.removeAll()
                            
                            for item in periodsArray {
                                let forecast = Forecast(item)
                                self.forecasts.append(forecast)
                            }
                            self.tableView.reloadData()
                        }
                    }
                    print("Validation Successful")
                case let .failure(error):
                    print(error)
                }
            }
        
        
    }
    

}

extension ForecastViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.forecasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ForecastTableViewCell", for: indexPath) as! ForecastTableViewCell
        let forecast = self.forecasts[indexPath.row]
        
        cell.dateLabel.text = forecast.startTime
        cell.temperatureLabel.text = "\(forecast.temperature) \(forecast.temperatureUnit)"
        cell.humidityLabel.text = "Humidity: \(forecast.relativeHumidity) %"
        cell.windSpeedLabel.text = "Wind Speed: \(forecast.windSpeed)"
        cell.forecastLabel.text = forecast.shortForecast
        
        if let iconUrl = URL(string: forecast.iconUrl) {
            cell.forecastImageView.kf.setImage(with: iconUrl)
        }
        
        
        
        
        return cell
    }
    
    
    
    
    
}
