//
//  CitiesViewController.swift
//  WeatherApp
//
//  Created by Mohamed Shehab on 3/11/24.
//

import UIKit
import Alamofire
import SwiftyJSON
import PKHUD

class CitiesViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getCities()
    }
    
    @IBOutlet weak var tableView: UITableView!
    var cities = [City]()
    
    func getCities(){
        
        HUD.show(.labeledProgress(title: "Loading Cities", subtitle: "Please Wait ..."))
        
        AF.request("https://www.theappsdr.com/api/cities")
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                
                HUD.hide()
                
                switch response.result {
                case .success:
                    
                    if let data = response.data {
                        if let json = try? JSON(data) {
                            
                            self.cities.removeAll()
                            
                            for item in json["cities"].arrayValue {
                                let city = City(item)
                                self.cities.append(city)
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "GotoForecastSegue" {
            let indexPath = self.tableView.indexPathForSelectedRow!
            let city = cities[indexPath.row]
            let vc = segue.destination as! ForecastViewController
            vc.city = city
            self.tableView.deselectRow(at: indexPath, animated: true)
        }
        
    }
    
}

extension CitiesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityCell", for: indexPath)
        let city = self.cities[indexPath.row]
        
        cell.textLabel?.text = city.name + ", " + city.state
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "GotoForecastSegue", sender: self)
    }
    
}
