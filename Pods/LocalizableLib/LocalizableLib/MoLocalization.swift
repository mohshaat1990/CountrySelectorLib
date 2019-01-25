//  Created by MOHAMED MAHMOUD  on 2/5/17.
//  Copyright © 2019 MOHAMED MAHMOUD . All rights reserved.
//////////////

import UIKit

struct Constants {
    static let appleLanguage = "AppleLanguages"
    static let defaultLanguage = "en"
    static let arabicLanguage = "ar"
}

public class MoLocalization: NSObject {
    
    static var isRightToLeftLanguage = false
    
    private class func reset(startStoryBorad: String, startViewController: String) {
        let rootviewcontroller: UIWindow = ((UIApplication.shared.delegate?.window)!)!
        let stry = UIStoryboard(name: startStoryBorad, bundle: nil)
        rootviewcontroller.rootViewController = stry.instantiateViewController(withIdentifier: startViewController)
    }
    
    public class func setCurrentLang(lang: String, isRightToLeft: Bool = false, forceReset: Bool = false , startStoryBorad: String? = nil, startViewController: String? = nil) {
        MoLocalization.isRightToLeftLanguage = isRightToLeft
        let userdef = UserDefaults.standard
        userdef.set([lang], forKey: Constants.appleLanguage)
        userdef.synchronize()
        if isRightToLeft == true {
            enableRightToLeft()
        } else {
            enableLeftToRight()
        }
        if let startStoryBorad = startStoryBorad, let startViewController = startViewController, forceReset == true{
            reset(startStoryBorad: startStoryBorad, startViewController: startViewController)
        }
        
    }
    
    private class func enableRightToLeft() {
        UIView.appearance().semanticContentAttribute = .forceRightToLeft
        UINavigationBar .appearance().semanticContentAttribute = .forceRightToLeft
    }
    
    private class func enableLeftToRight() {
        UIView.appearance().semanticContentAttribute = .forceLeftToRight
        UINavigationBar .appearance().semanticContentAttribute = .forceLeftToRight
    }
    
    public class func currentAppleLanguage() -> String {
        let userdef = UserDefaults.standard
        let langArray = userdef.object(forKey: Constants.appleLanguage) as? NSArray
        let current = langArray?.firstObject as? String
        if let current = current {
            let currentWithoutLocale =  String(current[..<current.index(current.startIndex, offsetBy: 2)])
            return currentWithoutLocale
        }
        return Constants.defaultLanguage
    }
}


extension String {
    
    func localized() -> String {
        let path = Bundle.main.path(forResource: MoLocalization.currentAppleLanguage(), ofType: "lproj")
        let bundle = Bundle(path: path!)
        return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
    }
    
}
