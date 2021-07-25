//
//  ViewController.swift
//  WeatherCombine
//
//  Created by Sergey on 25.07.2021.
//

import UIKit
import Combine


class CityListUI: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    var VM: CityListVM? = nil
    
    
    var VMCancellable: Cancellable? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        self.citiesTable.delegate = self
        //        self.citiesTable.dataSource = self
        //        self.citiesTable.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        // Do any additional setup after loading the view.
        
        //        VM = .init(model: whetherSingleton)
        //        VMCancellable = VM?.objectWillChange.sink(receiveValue: { [weak self] in
        //            self?.citiesTable.reloadData()
        //        })
        //        citiesTable.reloadData()
    }
    
    
    @IBOutlet weak var citiesTable: UITableView!
    
    
    let cellReuseIdentifier = "cell"
    
    
    @IBOutlet weak var cityNameTextField: UITextField!
    
    
    @IBAction func addCityPressed(_ sender: UIButton) {
        let name = cityNameTextField.text ?? ""
        
        if name == ""{
            let alert = UIAlertController(title: "My Alert", message: "This is an alert.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                NSLog("The \"OK\" alert occured.")
            }))
            
            self.present(alert, animated: true, completion: nil)
        }
        
        whetherSingleton.requestCityWhether(cityName: name)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.VM?.cityWhetherList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellReuseIdentifier)!
        
        
        // set the text from the data model
        cell.textLabel?.text = self.VM?.cityWhetherList[indexPath.row].name
        return cell
    }
    
    //    func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
    //            if let cell = sender as? UITableViewCell {
    //                let selectedIndex = self.citiesTable.indexPath(for: cell)!.row
    //                if segue.identifier == "cityWhetherDetail" {
    //                    let vc = segue.destination as! CityWhetherDetail
    //                    vc.VM = VM?.cityWhetherList[selectedIndex]
    //                }
    //            }
    //        }
}

