//
//  ViewController.swift
//  weather-app
//
//  Created by admin on 26.02.22.
//

import UIKit
import CoreLocation

class TodayController: UIViewController {
    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var cityLabel: UILabel!
    @IBOutlet var humidty: UILabel!
    @IBOutlet var pressure: UILabel!
    @IBOutlet var wind: UILabel!
    @IBOutlet var windDirection: UILabel!
    @IBOutlet var clouds: UILabel!
    @IBOutlet var logo: UIImageView!

    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()

    @IBAction func onRefresh(_ sender: Any) {
        locationManager.requestLocation()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        weatherManager.delegate = self
    }
    
    @IBAction func onShare(_ sender: Any) {
        let items = [URL(string: "https://openweathermap.org")!]
        let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(ac, animated: true)
    }
}

extension TodayController: WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather weatherData: WeatherData) {
        DispatchQueue.main.async {
            self.temperatureLabel.text = "\(weatherData.main.temp)°C | \(weatherData.weather.first!.main)"
            print("https://openweathermap.org/img/wn/\(weatherData.weather.first!.icon)@2x.png")
            self.logo.loadFrom(URLAddress: "https://openweathermap.org/img/wn/\(weatherData.weather.first!.icon)@2x.png")
            self.cityLabel.text = "\(weatherData.name), \(weatherData.sys.country)"
            self.humidty.text = "\(weatherData.main.humidity) %"
            self.clouds.text = "\(weatherData.clouds.all) mm"
            self.wind.text = "\(weatherData.wind.speed) km/h"
            self.windDirection.text = "\(weatherData.wind.deg) °"
            self.pressure.text = "\(weatherData.main.pressure) hPa"
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

extension TodayController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.fetchWeather(latitude: lat, longitude: lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
