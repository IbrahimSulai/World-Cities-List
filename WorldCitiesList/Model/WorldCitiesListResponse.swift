//
//  WorldCityModel.swift
//  WorldCitiesList
//
//  Created by Ibrahim on 09/11/17.
//  Copyright © 2017 Ibrahim. All rights reserved.
//

import Foundation
import ObjectMapper

class WorldCityModel: Mappable {
    var country: String?
    var city: String?
    var accentCity: String?
    var region: String?
    var population: String?
    var latitude: String?
    var longitude: String?
    
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        country <- map["Country"]
        city <- map["City"]
        accentCity <- map["AccentCity"]
        region <- map["Region"]
        population <- map["Population"]
        latitude <- map["Latitude"]
        longitude <- map["Longitude"]
    }
}


