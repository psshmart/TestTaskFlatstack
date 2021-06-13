//
//  CountryInfoProtocol.swift
//  FlatstackIosTestApp
//
//  Created by Svetlana Safonova on 13.06.2021.
//

import UIKit

protocol CountryInfoViewInput: AnyObject {
    func countryDidLoad(countryInfo: CountryWithImages)
    var countryTableView: UITableView { get set }
}

protocol CountryInfoViewOutput {
    var countryData: CountryWithImages { get set }
    var view: CountryInfoViewInput? { get set }
    func didLoad()
}
