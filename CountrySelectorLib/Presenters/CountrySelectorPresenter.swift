//
//  CounterSelectorPresenter.swift
//  CountrySelector
//
//  Created by MoHamed Shaat on 1/24/19.
//  Copyright © 2019 shaat. All rights reserved.
//

import UIKit
import libPhoneNumber_iOS

class CountrySelectorPresenter: NSObject {
    
   private lazy var phoneUtil: NBPhoneNumberUtil = NBPhoneNumberUtil()
  var counterySelectorView: CounterySelectorView?
    
    func attatchView(counterySelectorView: CounterySelectorView) {
        self.counterySelectorView = counterySelectorView
    }
    
    func loadCountries() {
        var countries = [Country]()
        for code in Locale.isoRegionCodes as [String] {
            if let name = Locale.autoupdatingCurrent.localizedString(forRegionCode: code) {
                do {
                let phoneNumberExample =  try phoneUtil.getExampleNumber(forType: code, type: .MOBILE)
                    countries.append(Country(name: name, code: code, phoneCode:"+\(phoneUtil.getCountryCode(forRegion: code) ?? 0)", phoneNumberExample: "\(phoneNumberExample.nationalNumber.stringValue)", counterFlag: code.lowercased()))
                }  catch _ {
                    
                }
            }
        }
        
      self.counterySelectorView?.onSucessLoadingCountries(counteries: countries)
    }
    
    func countryName(from countryCode: String) -> String {
        if let name = (Locale.current as NSLocale).displayName(forKey: .countryCode, value: countryCode) {
            // Country name was found
            return name
        } else {
            // Country name cannot be found
            return countryCode
        }
    }
    
}
