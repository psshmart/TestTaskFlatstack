//
//  Countries.swift
//  FlatstackIosTestApp
//
//  Created by Svetlana Safonova on 12.06.2021.
//

import Foundation
import UIKit

class CountryWithImages {
    var country: Country
    var flagImage: UIImage?
    var image: UIImage?
    var images: [UIImage]?
    
    init(country: Country) {
        self.country = country
    }
}

// MARK: - Countries
struct Countries: Codable {
    let next: String
    let countries: [Country]
}

// MARK: - Country
struct Country: Codable {
    let name, continent, capital: String
    let population: Int
    let descriptionSmall, countryDescription: String
    let image: String
    let countryInfo: CountryInfo
    
    enum CodingKeys: String, CodingKey {
        case name, continent, capital, population
        case descriptionSmall = "description_small"
        case countryDescription = "description"
        case image
        case countryInfo = "country_info"
    }
}


// MARK: - CountryInfo
struct CountryInfo: Codable {
    let images: [String]
    let flag: String
}
