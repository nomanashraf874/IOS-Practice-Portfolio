//
//  WeatherManager.swift
//  Clima
//
//  Created by Noman Ashraf on 7/18/22.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation
protocol  WeatherManagerDelegate{
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    let weatherUrl = "https://api.openweathermap.org/data/2.5/weather?appid=219f31f58209f695f79668db78e4b321"
    
    func fetchWeather(cityName: String){
        let urlString = "\(weatherUrl)&q=\(cityName)&units=metric"
        performRequest(with: urlString)
    }
    func fetchWeather(lat: CLLocationDegrees, lon: CLLocationDegrees){
        let urlString = "\(weatherUrl)&lat=\(lat)&lon=\(lon)&units=metric"
        performRequest(with: urlString)
    }
    
    var delegate: WeatherManagerDelegate?
    
    func performRequest(with urlString: String){
        //Create a URL
        if let url = URL(string: urlString){
            //create URL session
            let session = URLSession(configuration: .default)
            //Give session a task
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let weather = self.parseJSON(safeData){
                        delegate?.didUpdateWeather(self, weather:weather)
                    }
                }
            }
            //Start task
            task.resume()
            
        }
    }
    func parseJSON(_ weatherData: Data)-> WeatherModel?
    {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            
            let  weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            return weather
            
            
        } catch {
            self.delegate?.didFailWithError(error: error)
            return nil
        }
        
    }
}
