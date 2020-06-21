//
//  CounterySelectorSearchViewController.swift
//  CountrySelector
//
//  Created by MoHamed Shaat on 1/18/19.
//  Copyright © 2019 shaat. All rights reserved.
//

import UIKit
import libPhoneNumber_iOS
 class CounterySelectorSearchViewController: UIViewController {
    @IBOutlet weak var counteryTableView: UITableView!
    var searchController: UISearchController!
    var searchBarPlaceHolder: String = ""
    var cancelButtonTitle: String = ""
    var viewControllerTitle: String = ""
    public weak var delegate: CounterySelectorDelegate?
    var countries:[Character : [Country]] = [Character : [Country]]()
    var filterCountries:[Character : [Country]] = [Character : [Country]]()
    var filterCountriesKeys = [Character]()
    lazy var phoneUtil: NBPhoneNumberUtil = NBPhoneNumberUtil()
    let cellReuseIdentifier = "CounterySelectorTableViewCell"
    let counterySelectorPresenter = CountrySelectorPresenter()
    public var countryDataType: CountryDataType = .phoneCode
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        setupNavigationAndSearchBar()
        counterySelectorPresenter.attatchView(counterySelectorView:self)
        counterySelectorPresenter.loadCountries(searchText: "")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.title = viewControllerTitle
        super.viewWillAppear(animated)
        if #available(iOS 11.0, *) {
            navigationItem.hidesSearchBarWhenScrolling = false
        }
    }
    
    func registerCell() {
        let bundle = Bundle(for: CounterySelectorTableViewCell.classForCoder())
      counteryTableView.register(UINib(nibName: cellReuseIdentifier, bundle: bundle), forCellReuseIdentifier: cellReuseIdentifier )
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if #available(iOS 11.0, *) {
            navigationItem.hidesSearchBarWhenScrolling = true
        }
    }
   
    public func getCountry (withRegionCode: String) {
        let counterySelectorPresenter = CountrySelectorPresenter()
        counterySelectorPresenter.attatchView(counterySelectorView:self)
        counterySelectorPresenter.getCountry(withRegionCode: withRegionCode)
    }
    
    @IBAction func dismissAction(_ sender: Any) {
        self.dismiss(animated:true, completion: nil)
    }

    func setupNavigationAndSearchBar() {
        if #available(iOS 11.0, *) {
            let searchController = UISearchController(searchResultsController: nil)
            let searchBar = searchController.searchBar
            searchBar.delegate = self
            searchBar.tintColor = UIColor.gray
            searchBar.barTintColor = UIColor.gray
            searchBar.placeholder = searchBarPlaceHolder
            searchBar.setValue(cancelButtonTitle, forKey:"_cancelButtonText")
            if let textfield = searchBar.value(forKey: "searchField") as? UITextField {
                textfield.textColor = UIColor.darkGray
                if let backgroundview = textfield.subviews.first {
                    backgroundview.backgroundColor = UIColor.white
                    backgroundview.layer.cornerRadius = 10;
                    backgroundview.clipsToBounds = true;
                }
            }
            
            if let navigationbar = self.navigationController?.navigationBar {
                navigationbar.barTintColor = UIColor.white
            }
            navigationItem.searchController = searchController
            navigationItem.hidesSearchBarWhenScrolling = false
            
        } else {
            self.searchController = UISearchController(searchResultsController:  nil)
            let searchBar = searchController.searchBar
            searchBar.delegate = self
            searchBar.tintColor = UIColor.gray
            searchBar.barTintColor = UIColor.gray
            self.searchController.searchBar.delegate = self
            self.searchController.hidesNavigationBarDuringPresentation = false
            self.searchController.dimsBackgroundDuringPresentation = true
            self.navigationController?.navigationItem.titleView = searchController.searchBar
            self.definesPresentationContext = true
        }
        
        let bundle = Bundle(for: CounterySelectorTableViewCell.classForCoder())
        let leftBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "ic_remove", in: bundle, compatibleWith: nil), style: .done, target: self, action: #selector(CounterySelectorSearchViewController.dismissAction))
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
    }
}

extension CounterySelectorSearchViewController: UITableViewDataSource, UITableViewDelegate {
    
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
        cell.setupCell(countery:filterCountries[filterCountriesKeys[indexPath.section]]![indexPath.row], countryDataType: countryDataType)
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let delegate = delegate {
            delegate.selectCountery(country: filterCountries[filterCountriesKeys[indexPath.section]]![indexPath.row])
        }
    }
}

extension CounterySelectorSearchViewController: CounterySelectorView {
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

extension CounterySelectorSearchViewController:UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
      counterySelectorPresenter.loadCountries(searchText: searchText)
    }
}

