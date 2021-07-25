//
//  WhetherModel.swift
//  WeatherCombine
//
//  Created by Daniil Ignatev on 25.07.2021.
//

import Foundation
import Combine



class WhetherModel: ObservableObject {
    @Published var cityWhetherList: Set<CityModel> = [.init(name: "Moscow"), .init(name: "Ulyanovsk")]
    
    
    func requestCityWhether(cityName: String) {
        //делаем запрос на сервак
        //парсим
        //создаем модель погоды города
        let cityModel = CityModel.init(name: cityName)
        self.cityWhetherList.insert(cityModel)
    }
}


var whetherSingleton = WhetherModel()

