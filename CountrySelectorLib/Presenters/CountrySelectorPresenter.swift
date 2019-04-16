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
    let bundle = Bundle(for: CounterySelectorTableViewCell.classForCoder())
    
    func attatchView(counterySelectorView: CounterySelectorView) {
        self.counterySelectorView = counterySelectorView
    }
    
    func loadCountries() {
        var countries = [Country]()
        for code in Locale.isoRegionCodes as [String] {
            let country = loadCountry(regionCode: code)
            if let country = country {
             countries.append(country)
            }
        }
        self.counterySelectorView?.onSucessLoadingCountries(counteries: countries)
    }
    
    func getCountry (withRegionCode: String) {
        let country = loadCountry(regionCode: withRegionCode)
        self.counterySelectorView?.onSucessLoadingCountry(regionCode: withRegionCode, country: country)
    }
    
    func loadCountry(regionCode: String)-> Country? {
        if let name = Locale.autoupdatingCurrent.localizedString(forRegionCode: regionCode) {
            do {
                guard let imageURL = bundle.url(forResource: regionCode.lowercased(), withExtension: "png") else { return nil }
                let phoneNumberExample =  try phoneUtil.getExampleNumber(forType: regionCode, type: .MOBILE)
                let country = Country(name: name, code: regionCode, phoneCode:"+\(phoneUtil.getCountryCode(forRegion: regionCode) ?? 0)", phoneNumberExample: "\(phoneNumberExample.nationalNumber.stringValue)", counterFlag: UIImage(contentsOfFile: imageURL.path ))
                return country
            }  catch _ {
                
            }
        }
        return nil
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
