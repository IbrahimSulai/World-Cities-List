//
//  WorldCitiesListResponse.swift
//  WorldCitiesList
//
//  Created by Ibrahim on 09/11/17.
//  Copyright © 2017 Ibrahim. All rights reserved.
//

import Foundation
import ObjectMapper

class WorldCitiesListResponse: Mappable, NSCopying {
    var worldCitiesList: [WorldCityModel] = []
    
    // required initializer for Mappable protocol
    required init?(map: Map) {
        mapping(map: map)
    }
    
    // required initializer for the Copying protocol
    init(worldCitiesList: [WorldCityModel]) {
        self.worldCitiesList = worldCitiesList
    }
    
    // Mappable
    func mapping(map: Map) {
        worldCitiesList <- map[JsonKeyConstants.WorldCitiesListKey]
    }
    
    // Copying protocol
    func copy(with zone: NSZone? = nil) -> Any {
        let copy = WorldCitiesListResponse(worldCitiesList: worldCitiesList)
        return copy
    }
}

