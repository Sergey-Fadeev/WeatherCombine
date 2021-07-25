//
//  WhetherModel.swift
//  WeatherCombine
//
//  Created by Daniil Ignatev on 25.07.2021.
//

import Foundation
import Combine



class WhetherModel: ObservableObject {
    @Published var cityWhetherList: [CityModel] = [.init(name: "Moscow"), .init(name: "Ulyanovsk")]
    
    
    func requestCityWhether(cityName: String) {
        //делаем запрос на сервак
        //парсим
        //создаем модель погоды города
        let cityModel = CityModel.init(name: cityName)
        if !cityWhetherList.contains(cityModel){
            self.cityWhetherList.insert(cityModel, at: 0)
        }
    }
}


var whetherSingleton = WhetherModel()

