//
//  CounterySelectorSearchBar.swift
//  CountrySelector
//
//  Created by MoHamed Shaat on 1/15/19.
//  Copyright © 2019 shaat. All rights reserved.
//
import Foundation
import UIKit
import libPhoneNumber_iOS



public class CounterySelectorSearchBar: UIView {
    
   @IBOutlet weak var counteryTableView: UITableView!
   @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchBarConstraint: NSLayoutConstraint!
    
   let cellReuseIdentifier = "CounterySelectorTableViewCell"
   var delegate: CounterySelectorDelegate?
   private var countries:[Country] = [Country]()
   private var filterCountries:[Country] = [Country]()
   private lazy var phoneUtil: NBPhoneNumberUtil = NBPhoneNumberUtil()
    
   required init?(coder aDecoder: NSCoder) {
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
        self.searchBar.delegate = self
        self.searchBar.placeholder = "Search for country"
        self.searchBar.returnKeyType = .done
        let counterySelectorPresenter = CounterySelectorPresenter()
        counterySelectorPresenter.attatchView(counterySelectorView:self)
        counterySelectorPresenter.loadCountries()
    }
    
    func registerCell() {
        counteryTableView.register(UINib(nibName: cellReuseIdentifier, bundle: nil), forCellReuseIdentifier: cellReuseIdentifier )
    }
    
}

extension CounterySelectorSearchBar {
    
    func showAlertViewController(parent: UIViewController, actionSheetStyle: UIAlertController.Style = .actionSheet, hideSarchBar: Bool = false, cancelTitle:String = "Cancel", searchTitle: String = "Search for country") {
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
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterCountries.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:cellReuseIdentifier) as! CounterySelectorTableViewCell
        cell.setupCell(countery: filterCountries[indexPath.row])
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let delegate = delegate {
            delegate.selectCountery(countery: filterCountries[indexPath.row])
        }
    }
    
    
}

extension CounterySelectorSearchBar:UISearchBarDelegate {

   public func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
   public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
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

extension CounterySelectorSearchBar: CounterySelectorView {
    
    func onSucessLoadingCountries(counteries: [Country]) {
        self.countries = counteries
        self.filterCountries = countries
        self.counteryTableView.reloadData()
    }
}





