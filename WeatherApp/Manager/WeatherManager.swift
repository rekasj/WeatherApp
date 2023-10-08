//
//  WeatherManager.swift
//  WeatherApp
//
//  Created by Jakub Rękas on 05/10/2023.
//
import Foundation
import CoreLocation

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=1b79a84a8b3cdb21529354cb06beee7e&units=metric"
    
    func fetchWeather(cityName: String, completed: @escaping (WeatherModel) -> (), failed: @escaping () -> ()) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(with: urlString) { weatherModel in
            completed(weatherModel)
        } failed: {
            failed()
        }
    }
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees, completed: @escaping (WeatherModel) -> (), failed: @escaping () -> ()) {
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: urlString) { weatherModel in
            completed(weatherModel)
        } failed: {
            failed()
        }
    }
    
    func performRequest(with urlString: String, completed: @escaping (WeatherModel) -> (), failed: @escaping () -> ()) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    failed()
                    return
                }
                if let safeData = data {
                    if let weather = self.parseJSON(safeData) {
                        completed(weather)
                    } else {
                        failed()
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherDto.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            return weather
            
        } catch {
            return nil
        }
    }
    
    
    
}
