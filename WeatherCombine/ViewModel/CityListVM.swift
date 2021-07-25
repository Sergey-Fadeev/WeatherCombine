//
//  CityListVM.swift
//  WeatherCombine
//
//  Created by Daniil Ignatev on 25.07.2021.
//

import Foundation
import Combine



class CityListVM: ObservableObject {
    @Published var cityWhetherList: [CityWhetherVM] = []
    
    
    var cityWhetherListCancellable: Cancellable? = nil
    
    
    init(model: WhetherModel) {
        cityWhetherList = model.cityWhetherList.compactMap({.init(model: $0)})
        
        cityWhetherListCancellable = whetherSingleton
            .objectWillChange
            .sink(receiveValue: {[weak self] in
                DispatchQueue.main.async { [weak self] in
                    self?.cityWhetherList = model.cityWhetherList.compactMap({.init(model: $0)})
                }
            })
    }
}
