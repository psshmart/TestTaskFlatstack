//
//  CountriesProtocol.swift
//  FlatstackIosTestApp
//
//  Created by Svetlana Safonova on 13.06.2021.
//

import UIKit

protocol CountriesViewOutput {
    func loadData(isRefreshing: Bool)
    var view: CountriesViewInput? { get set }
}

protocol CountriesViewInput: AnyObject {
    var countriesTableView: UITableView { get set }
    func dataDidLoad(data: [CountryWithImages])
}
