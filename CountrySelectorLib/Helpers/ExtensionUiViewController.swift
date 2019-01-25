//
//  ExtensionUiViewController.swift
//  CountrySelector
//
//  Created by MoHamed Shaat on 1/24/19.
//  Copyright © 2019 shaat. All rights reserved.
//

import UIKit

extension UIViewController {
  public func showCounteryCodeViewController(delegate:CounterySelectorDelegate ,cancelTitle:String = "Cancel", searchPlaceHolder: String = "Search for country", viewControllerTilte: String = "Select country") {
        let bundle = Bundle(for: CounterySelectorSearchViewController.classForCoder())
        let counterySelectorSearchViewController = CounterySelectorSearchViewController(nibName: "CounterySelectorSearchViewController", bundle: bundle)
        counterySelectorSearchViewController.viewControllerTitle = viewControllerTilte
        counterySelectorSearchViewController.delegate = delegate
        counterySelectorSearchViewController.searchBarPlaceHolder = searchPlaceHolder
        counterySelectorSearchViewController.cancelButtonTitle = cancelTitle
        let navigationController = UINavigationController(rootViewController: counterySelectorSearchViewController)
        navigationController.navigationBar.shouldRemoveShadow(true)
        counterySelectorSearchViewController.delegate = delegate
        self.present(navigationController, animated: true, completion: nil)
       
    }
}
