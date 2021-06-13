//
//  CountryInfoPresenter.swift
//  FlatstackIosTestApp
//
//  Created by Svetlana Safonova on 13.06.2021.
//

import UIKit

class CountryInfoPresenter: CountryInfoViewOutput {
    var countryData: CountryWithImages
    weak var view: CountryInfoViewInput?
    
    init(countryData: CountryWithImages) {
        self.countryData = countryData
    }
       
    
    func didLoad() {
        self.view?.countryDidLoad(countryInfo: self.countryData)
    }
    
    
}
