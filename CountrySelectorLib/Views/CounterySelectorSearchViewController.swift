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
    var delegate: CounterySelectorDelegate?
    var countries:[Country] = [Country]()
    var filterCountries:[Country] = [Country]()
    lazy var phoneUtil: NBPhoneNumberUtil = NBPhoneNumberUtil()
    let cellReuseIdentifier = "CounterySelectorTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        setupNavigationAndSearchBar()
        let counterySelectorPresenter = CountrySelectorPresenter()
        counterySelectorPresenter.attatchView(counterySelectorView:self)
        counterySelectorPresenter.loadCountries()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.title = viewControllerTitle
        super.viewWillAppear(animated)
        if #available(iOS 11.0, *) {
            navigationItem.hidesSearchBarWhenScrolling = false
        }
    }
    
    func registerCell() {
      counteryTableView.register(UINib(nibName: cellReuseIdentifier, bundle: nil), forCellReuseIdentifier: cellReuseIdentifier )
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if #available(iOS 11.0, *) {
            navigationItem.hidesSearchBarWhenScrolling = true
        }
    }
   
    @IBAction func dismissAction(_ sender: Any) {
        self.dismiss(animated:true, completion: nil)
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
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
        
        let leftBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "ic_remove"), style: .done, target: self, action: #selector(CounterySelectorSearchViewController.dismissAction))
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
    }
}

extension CounterySelectorSearchViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterCountries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:cellReuseIdentifier) as! CounterySelectorTableViewCell
        cell.setupCell(countery: filterCountries[indexPath.row])
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let delegate = delegate {
         delegate.selectCountery(countery: filterCountries[indexPath.row])
        }
    }
}

extension CounterySelectorSearchViewController: CounterySelectorView {
    
    func onSucessLoadingCountries(counteries: [Country]) {
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
        filterContentForSearchText(searchText:searchText)
    }
    
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        if searchText != "" {
            filterCountries = countries.filter {countery in
                return   countery.name.lowercased().contains(searchText.lowercased())
            }
        } else {
            self.filterCountries = self.countries}
        self.counteryTableView.reloadData()
    }
    
}

