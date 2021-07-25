//
//  CityWhetherVM.swift
//  WeatherCombine
//
//  Created by Daniil Ignatev on 25.07.2021.
//

import Foundation
import Combine



class CityWhetherVM: ObservableObject {
    
    let name: String
    
    
    init(model: CityModel) {
        self.name = model.name
    }
}
