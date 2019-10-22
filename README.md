# CountrySelectorLib

- Choose the country (flag, Mobile Code, Mobile Number Example)
- Choose Currency 
- Support localization 
- Support multiple controls ActionSheet , UIAlertViewController , SearchBarController


## Installation

using pods

```bash
pod 'CountrySelectorLib'
```


## Usage

#  Action Sheet

![actionsheetGif](https://user-images.githubusercontent.com/11280137/61086244-a11f1680-a432-11e9-8910-e99fd7925a61.gif)

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

![alertViewControllerGif](https://user-images.githubusercontent.com/11280137/61086242-9fede980-a432-11e9-9818-4c282a4efe56.gif)

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

![searchViewController](https://user-images.githubusercontent.com/11280137/61086234-982e4500-a432-11e9-9b5c-8437f4a227c4.gif)

```swift
import CountrySelectorLib
showCounteryCodeViewController(delegate: self)
```
// there are another optional parameters 

```swift
showCounteryCodeViewController(delegate: self, cancelTitle: "Cancel", searchPlaceHolder: "Search", viewControllerTilte: "Search For Country")
```
# to show Currency 

![currency gif](https://user-images.githubusercontent.com/11280137/61189229-d160f200-a68a-11e9-86a4-c4091839c0d8.gif)

```swift
let countryData: CountryDataType = .Currency
let counterySelectorSearchBar  = CounterySelectorSearchBar()
counterySelectorSearchBar.showAlertViewController(parent:self,countryDataType: countryData,actionSheetStyle: .alert)
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

