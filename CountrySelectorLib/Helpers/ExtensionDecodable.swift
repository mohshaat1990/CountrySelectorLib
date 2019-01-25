//
//  ExtensionDecodable.swift
//  CountrySelector
//
//  Created by MoHamed Shaat on 1/24/19.
//  Copyright © 2019 shaat. All rights reserved.
//

import UIKit

extension Decodable {

    static func fromJSON<T:Decodable>(_ fileName: String, fileExtension:String="json") -> [T]? {
        let url = Bundle.main.url(forResource: fileName, withExtension: fileExtension)!
        do {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode([T].self, from: data)
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
}
