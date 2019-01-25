//  Created by MOHAMED MAHMOUD  on 2/5/17.
//  Copyright © 2019 MOHAMED MAHMOUD . All rights reserved.
//////////////
import Foundation
import UIKit
extension  UILabel {
    @IBInspectable var localizationKey: String {
    set {
        self.text = newValue.localized()
        }
     get {
        return self.text!
        }
    }
}

extension  UITextField {
    @IBInspectable var localizationKey: String {
     set {
          self.placeholder=newValue.localized()
         }
     get {
          return self.placeholder!
         }
    }
}

extension  UITextView {
    @IBInspectable var localizationKey: String {
        set {
            self.text=newValue.localized()
        }
        get {
            return self.text!
        }
    }
}

extension  UIButton {
    @IBInspectable var localizationKey: String {
        set {
            setTitle(newValue.localized(), for: .normal)
        }
        get {
            return (self.titleLabel?.text)!
        }
    }
}

extension UIImage {
    public func flippedImage() -> UIImage? {
        if let cgImag = self.cgImage {
            let flippedimg = UIImage(cgImage: cgImag, scale: self.scale, orientation: UIImage.Orientation.upMirrored)
            return flippedimg
        }
        return nil
    }
}

extension UIImageView {
    @IBInspectable var flipRightToLeft: Bool {
        set {
            if MoLocalization.isRightToLeftLanguage == true && newValue == true {
                let rotatedImage = self.image?.flippedImage()
                self.image = rotatedImage
            }
        }
        get {
            return self.flipRightToLeft

        }
    }
}
