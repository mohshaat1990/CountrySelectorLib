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
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func showActionsheet(_ sender: Any) {
        
   //  showCounteryCodeViewController(delegate: self)
      let counterySelectorSearchBar  = CounterySelectorSearchBar()
        counterySelectorSearchBar.showAlertViewController(parent:self,actionSheetStyle: .actionSheet)
      //  counterySelectorSearchBar.pre
    
       
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
    
    func selectCountery(countery: Country) {
        self.counteryImage.image = UIImage(named: countery.counterFlag)
        self.countryNameLabel.text = countery.name
        self.counteryCodeLabel.text = countery.phoneCode
        self.mobileNumberExample.text = countery.phoneNumberExample
      self.dismiss(animated: true, completion: nil)
    }
}

