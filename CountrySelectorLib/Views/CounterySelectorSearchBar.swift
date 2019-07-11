//
//  CounterySelectorSearchBar.swift
//  CountrySelector
//
//  Created by MoHamed Shaat on 1/15/19.
//  Copyright © 2019 shaat. All rights reserved.
//
import UIKit
import libPhoneNumber_iOS
public class CounterySelectorSearchBar: UIView {
    
    @IBOutlet weak var counteryTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchBarConstraint: NSLayoutConstraint!
    let cellReuseIdentifier = "CounterySelectorTableViewCell"
    public var delegate: CounterySelectorDelegate?
    var countries:[Character : [Country]] = [Character : [Country]]()
    var filterCountries:[Character : [Country]] = [Character : [Country]]()
    var filterCountriesKeys = [Character]()
    lazy var phoneUtil: NBPhoneNumberUtil = NBPhoneNumberUtil()
    let counterySelectorPresenter = CountrySelectorPresenter()
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupXib()
    }
    
    override init(frame:CGRect) {
        super.init(frame: frame)
        setupXib()
    }
    
    func setupXib(){
        fromNib()
        registerCell()
        self.counteryTableView.dataSource = self
        self.counteryTableView.delegate = self
        self.counteryTableView.rowHeight = 44;
        self.searchBar.delegate = self
        self.searchBar.placeholder = "Search for country"
        self.searchBar.returnKeyType = .done
        let textFieldInsideUISearchBar = searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideUISearchBar?.font = textFieldInsideUISearchBar?.font?.withSize(15)
        counterySelectorPresenter.attatchView(counterySelectorView:self)
        counterySelectorPresenter.loadCountries(searchText: "")
    }
    
    func registerCell() {
        let bundle = Bundle(for: CounterySelectorTableViewCell.classForCoder())
        counteryTableView.register(UINib(nibName: cellReuseIdentifier, bundle: bundle), forCellReuseIdentifier: cellReuseIdentifier )
    }
    
    public func getCountry (withRegionCode: String) {
        let counterySelectorPresenter = CountrySelectorPresenter()
        counterySelectorPresenter.attatchView(counterySelectorView:self)
        counterySelectorPresenter.getCountry(withRegionCode: withRegionCode)
    }
    
}

extension CounterySelectorSearchBar {
    public func showAlertViewController(parent: UIViewController, actionSheetStyle: UIAlertController.Style = .actionSheet, hideSarchBar: Bool = false, cancelTitle:String = "Cancel", searchTitle: String = "Search for country") {
        let alertController = UIAlertController(title:"", message: nil, preferredStyle: actionSheetStyle)
        let customView = CounterySelectorSearchBar(frame: CGRect(x: 0, y: 0, width: alertController.view.frame.width, height: 200))
        customView.delegate = parent as? CounterySelectorDelegate
        customView.searchBar.placeholder = searchTitle
        if hideSarchBar == true {
            customView.searchBarConstraint.constant = 0
        }
        alertController.view.addSubview(customView)
        customView.translatesAutoresizingMaskIntoConstraints = false
        customView.topAnchor.constraint(equalTo: alertController.view.topAnchor, constant: 10).isActive = true
        customView.rightAnchor.constraint(equalTo: alertController.view.rightAnchor, constant: -10).isActive = true
        customView.leftAnchor.constraint(equalTo: alertController.view.leftAnchor, constant: 10).isActive = true
        if actionSheetStyle == .actionSheet {
            customView.bottomAnchor.constraint(equalTo: alertController.view.bottomAnchor, constant: -70).isActive = true
        } else {
            customView.bottomAnchor.constraint(equalTo: alertController.view.bottomAnchor, constant: -50).isActive = true
        }
        //customView.heightAnchor.constraint(equalToConstant: 320).isActive = true
        alertController.view.translatesAutoresizingMaskIntoConstraints = false
        alertController.view.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.height * 0.75).isActive = true
        let cancelAction = UIAlertAction(title: cancelTitle, style: .cancel, handler: {(alert: UIAlertAction!) in print("cancel")})
        alertController.addAction(cancelAction)
        parent.present(alertController, animated: true, completion:{})
    }
    
    
}

extension CounterySelectorSearchBar: UITableViewDataSource, UITableViewDelegate {
    public func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return filterCountriesKeys.map { String($0) }
    }
    public func numberOfSections(in tableView: UITableView) -> Int {
        return filterCountriesKeys.count
    }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterCountries[filterCountriesKeys[section]]!.count
    }
    
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
       return String(describing:filterCountriesKeys[section])
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:cellReuseIdentifier) as! CounterySelectorTableViewCell
        cell.setupCell(countery:filterCountries[filterCountriesKeys[indexPath.section]]![indexPath.row])
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let delegate = delegate {
            delegate.selectCountery(country: filterCountries[filterCountriesKeys[indexPath.section]]![indexPath.row])
        }
    }
    
    
}

extension CounterySelectorSearchBar:UISearchBarDelegate {
    
    public func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        counterySelectorPresenter.loadCountries(searchText: searchText)
    }
    
}

extension CounterySelectorSearchBar: CounterySelectorView {
    func onSucessLoadingCountry(regionCode: String, country: Country?) {
            delegate?.selectCountery(regionCode: regionCode, country: country)
    }
    
    func onSucessLoadingCountries(counteries: [Character : [Country]]) {
        filterCountriesKeys = Array(counteries.keys).sorted()
        self.countries = counteries
        self.filterCountries = countries
        self.counteryTableView.reloadData()
    }
}





