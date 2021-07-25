//
//  CityWhetherDetail.swift
//  WeatherCombine
//
//  Created by Daniil Ignatev on 25.07.2021.
//

import UIKit



class CityWhetherDetail: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    
    var VM: CityWhetherVM? = nil
    
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        nameLabel.text = VM?.name
    }
}
