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
        self.citiesTable.delegate = self
        self.citiesTable.dataSource = self
        self.citiesTable.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        
        
        VM = .init(model: whetherSingleton)
        VMCancellable = VM?
            .objectWillChange
            .sink(receiveValue: { [weak self] in
                DispatchQueue.main.async { [weak self] in
                    if self != nil{
                        let currentCount = self!.citiesTable.numberOfRows(inSection: 0)
                        let toInsert = self!.VM!.cityWhetherList.count - currentCount
                        
                        self?.citiesTable.beginUpdates()
                        //self?.tblView.insertRows(at: [IndexPath.init(row: self.yourArray.count-1, section: 0)], with: .automatic)
                        for _ in 0..<toInsert{
                            self?.citiesTable.insertRows(at: [IndexPath.init(row: 0, section: 0)], with: .automatic)
                        }
                        self?.citiesTable.endUpdates()
                    }
                }
            })
        citiesTable.reloadData()
    }
    
    
    @IBOutlet weak var citiesTable: UITableView!
    
    
    let cellReuseIdentifier = "cell"
    
    
    @IBOutlet weak var cityNameTextField: UITextField!
    
    
    @IBAction func addCityPressed(_ sender: UIButton) {
        let name = cityNameTextField.text ?? ""
        
        guard name != "" else {
            let alert = UIAlertController(title: "My Alert", message: "This is an alert.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                NSLog("The \"OK\" alert occured.")
            }))
            
            self.present(alert, animated: true, completion: nil)
            return
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
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "cityWhetherDetail", sender: tableView.cellForRow(at: indexPath))
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cell = sender as? UITableViewCell {
            let selectedIndex = self.citiesTable.indexPath(for: cell)!.row
            if segue.identifier == "cityWhetherDetail" {
                let vc = segue.destination as! CityWhetherDetail
                vc.VM = VM?.cityWhetherList[selectedIndex]
            }
        }
    }
}

