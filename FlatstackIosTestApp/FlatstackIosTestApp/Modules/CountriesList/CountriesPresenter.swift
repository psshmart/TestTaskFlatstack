//
//  CountriesPresenter.swift
//  FlatstackIosTestApp
//
//  Created by Svetlana Safonova on 13.06.2021.
//

import UIKit

class CountriesPresenter: CountriesViewOutput {
   
    private var countriesData: [Country] = []
    private var countriesWithImage: [CountryWithImages] = []
    private let countriesService = CountriesService()
    private let imageService = ImageService()
    
    weak var view: CountriesViewInput?
    
    
    func loadData(isRefreshing: Bool) {
        loadCountries(isRefreshing: isRefreshing) { [weak self] in
            self?.loadFlagImages()
            self?.loadImages()
        }
    }
    
    func refreshCountriesList() {
        self.countriesWithImage = []
        
    }
    
    private func loadImages() {
        for country in countriesWithImage {
            if country.country.image == "" {
                imageService.getCountryImages(urlStrings: country.country.countryInfo.images) { result in
                    switch result {
                    case .success(let images):
                        country.images = images
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            } else {
                imageService.getCountryImages(urlStrings: [country.country.image]) { result in
                    switch result {
                    case .success(let images):
                        country.images = images
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
    
    private func loadFlagImages() {
        for country in countriesWithImage {
            let urlString = country.country.countryInfo.flag
            imageService.getCountryFlag(urlString: urlString) { [weak self] result in
                switch result {
                case .success(let image):
                    country.flagImage = image
                    self?.view?.countriesTableView.reloadData()
                case .failure(let error):
                    
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    
    private func loadCountries(isRefreshing: Bool, completion: @escaping () -> Void) {
        countriesService.getCountries(isRefreshing: isRefreshing) { [weak self] result in
            switch result {
            case .success(let countries):
                self?.countriesData = countries
                self?.countriesWithImage = countries.map {
                    let countryData = CountryWithImages(country: $0)
                    return countryData
                }
                if let loadedData = self?.countriesWithImage {
                    self?.view?.dataDidLoad(data: loadedData)
                }
                completion()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    
}
