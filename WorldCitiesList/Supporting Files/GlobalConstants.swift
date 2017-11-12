//
//  GlobalConstants.swift
//  WorldCitiesList
//
//  Created by Ibrahim on 11/11/17.
//  Copyright © 2017 Ibrahim. All rights reserved.
//

import UIKit

// MARK: - Identifier Constants
struct IdentifierConstants {
    static let worldCityDetailsTableViewCellIdentifier = "WorldCityDetailsTableViewCellIdentifier"
}

// MARK: - Nib Name Constants
struct NibNameConstants {
    static let worldCityDetailsTableViewCellNibName = "WorldCityDetailsTableViewCell"
}

// MARK: - JsonKey Constants
struct JsonKeyConstants {
    static let WorldCitiesListKey = "WorldCitiesList"
    static let countryCodeKey = "Country"
    static let cityNameKey = "City"
    static let accentCityNameKey = "AccentCity"
    static let regionKey = "Region"
    static let populationKey = "Population"
    static let latitudeKey = "Latitude"
    static let longitudeKey = "Longitude"
}

// MARK: - AppUrl Constants
struct AppUrlConstants {
    static let worldCitiesDetailsJsonName = "WorldCitiesDetails"
    static let unitTestSampleWorldCitiesDetailsJsonName = "UnitTest_Sample_WorldCitiesDetails"
    static let jsonExtension = "json"
}

// MARK: - ErrorMessage Constants
struct ErrorMessageConstants {
    static let jsonStringConversionError = "Json String conversion error"
    static let fileNotExist = "File not Exist at this path"
}

class GlobalConstants {
    
    // MARK: - sortingType Enum
    enum SortingType {
        case ascendingOrder
        case descendingOrder
    }
}
