//
//  ViewController.swift
//  CountrySelector
//
//  Created by MoHamed Shaat on 1/15/19.
//  Copyright © 2019 shaat. All rights reserved.
//

import UIKit
import LocalizableLib

class ViewController: UIViewController {
    
    @IBOutlet weak var counteryImage: UIImageView!
    @IBOutlet weak var countryNameLabel: UILabel!
    @IBOutlet weak var counteryCodeLabel: UILabel!
    @IBOutlet weak var mobileNumberExample: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let counterySelectorSearchBar  = CounterySelectorSearchBar()
        counterySelectorSearchBar.delegate = self
        counterySelectorSearchBar.getCountry(withRegionCode:"eg")
    }
    
    @IBAction func showActionsheet(_ sender: Any) {
        let counterySelectorSearchBar  = CounterySelectorSearchBar()
        counterySelectorSearchBar.showAlertViewController(parent:self,actionSheetStyle: .actionSheet)
    }
    
    @IBAction func showAlert(_ sender: Any) {
        let counterySelectorSearchBar  = CounterySelectorSearchBar()
        counterySelectorSearchBar.showAlertViewController(parent:self,actionSheetStyle: .alert)
    }
    
    @IBAction func showSearchController(_ sender: Any) {
        showCounteryCodeViewController(delegate: self)
    }
    
    
    
}

extension ViewController: CounterySelectorDelegate {
    
    func selectCountery(regionCode: String, country: Country?) {
        if let country = country {
            self.counteryImage.image = country.counterFlag
            self.countryNameLabel.text = country.name
            self.counteryCodeLabel.text = country.phoneCode
            self.mobileNumberExample.text = country.phoneNumberExample
        }
    }
    
    func selectCountery(country: Country) {
        self.counteryImage.image = country.counterFlag
        self.countryNameLabel.text = country.name
        self.counteryCodeLabel.text = country.phoneCode
        self.mobileNumberExample.text = country.phoneNumberExample
        self.dismiss(animated: true, completion: nil)
    }
}

