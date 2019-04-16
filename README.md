# CountrySelectorLib

- Choose the country (flag, Mobile Code, Mobile Number Example)
- Support localization 
- Support multiple controls ActionSheet , UIAlertViewController , SearchBarController

## Installation

using pods

```bash
pod 'CountrySelectorLib', '~> 0.1.8'
```

## Usage

#  Action Sheet

![action sheet](https://user-images.githubusercontent.com/11280137/51776196-e0fe7580-2100-11e9-9e00-8f5d2516cbf9.gif)

```swift
import CountrySelectorLib

 let counterySelectorSearchBar  = CounterySelectorSearchBar( )     
 counterySelectorSearchBar.showAlertViewController(parent:self,actionSheetStyle: .actionSheet)
```
// there are another optional parameters 

```swift
 counterySelectorSearchBar.showAlertViewController(parent: self, actionSheetStyle: .actionSheet, hideSarchBar: true, cancelTitle: "Cancel", searchTitle: "Search For Country")
```
#  Alert View

![alertview](https://user-images.githubusercontent.com/11280137/51776222-f4a9dc00-2100-11e9-9a34-0a433b540a06.gif)
```swift
import CountrySelectorLib

 let counterySelectorSearchBar  = CounterySelectorSearchBar( )     
 counterySelectorSearchBar.showAlertViewController(parent:self,actionSheetStyle: .alert)
```
// there are another optional parameters 

```swift
 counterySelectorSearchBar.showAlertViewController(parent: self, actionSheetStyle: .alert, hideSarchBar: true, cancelTitle: "Cancel", searchTitle: "Search For Country")
```

#  SearchBarController

![serachviewcontroller](https://user-images.githubusercontent.com/11280137/51776223-f5db0900-2100-11e9-9587-cd269904f289.gif)

```swift
import CountrySelectorLib
showCounteryCodeViewController(delegate: self)
```
// there are another optional parameters 

```swift
showCounteryCodeViewController(delegate: self, cancelTitle: "Cancel", searchPlaceHolder: "Search", viewControllerTilte: "Search For Country")
```
# to get specific country 

 ```swift
 let counterySelectorSearchBar  = CounterySelectorSearchBar()
 counterySelectorSearchBar.delegate = self
 counterySelectorSearchBar.getCountry(withRegionCode:"eg")
```

# you should implement Delegate 

```swift
extension ViewController: CounterySelectorDelegate {
    func selectCountery(countery: Country) {
        self.counteryImage.image = countery.counterFlag
        self.countryNameLabel.text = countery.name
        self.counteryCodeLabel.text = countery.phoneCode
        self.mobileNumberExample.text = countery.phoneNumberExample
        self.dismiss(animated: true, completion: nil)
    }
    
    func selectCountery(regionCode: String, country: Country?) {
       if let country = country {
       self.counteryImage.image = country.counterFlag
       self.countryNameLabel.text = country.name
       self.counteryCodeLabel.text = country.phoneCode
       self.mobileNumberExample.text = country.phoneNumberExample
     }
    }
}
```

