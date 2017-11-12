//
//  WorldCityModel.swift
//  WorldCitiesList
//
//  Created by Ibrahims on 10/11/17.
//  Copyright © 2017 Ibrahim. All rights reserved.
//

import Foundation
import ObjectMapper

class WorldCityModel: Mappable {
    var countryCode: String?
    var cityName: String?
    var accentCityName: String?
    var region: Float?
    var population: Int?
    var latitude: Float?
    var longitude: Float?
    
    // required initializer for Mappable protocol
    required init?(map: Map) {
        mapping(map: map)
    }
    
    // Mappable
    func mapping(map: Map) {
        countryCode <- map[JsonKeyConstants.countryCodeKey]
        cityName <- map[JsonKeyConstants.cityNameKey]
        accentCityName <- map[JsonKeyConstants.accentCityNameKey]
        region <- map[JsonKeyConstants.regionKey]
        population <- map[JsonKeyConstants.populationKey]
        latitude <- map[JsonKeyConstants.latitudeKey]
        longitude <- map[JsonKeyConstants.longitudeKey]
    }
}

