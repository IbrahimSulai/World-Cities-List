//
//  WorldCityViewModel.swift
//  WorldCitiesList
//
//  Created by Ibrahim on 09/11/17.
//  Copyright © 2017 Ibrahim. All rights reserved.
//

import Foundation

class WorldCityViewModel: NSObject {

    // Response used to display
    var worldCitiesListResponse : WorldCitiesListResponse?
    
    // UnFiltered Response used to display
    var unFilteredWorldCitiesListResponse : WorldCitiesListResponse?
    
    // function to get WorldCitiesResponse
    func getWorldCitiesResponse(delegateBlock: @escaping (() -> Void)) {
        let worldCitiesService: WorldCitiesService = WorldCitiesService()
        worldCitiesService.getWorldCities { worldCitiesListResponse in
            self.worldCitiesListResponse = worldCitiesListResponse
            self.unFilteredWorldCitiesListResponse = self.worldCitiesListResponse?.copy() as? WorldCitiesListResponse
            delegateBlock()
        }
    }
    
    // function to get cities count
    func getCitiesCount() -> Int {
        if let worldCitiesList : [WorldCityModel] = worldCitiesListResponse?.worldCitiesList {
            return worldCitiesList.count
        } else {
            return 0
        }
    }
    
    // function to get cities details at paticular index
    func getCityDetails(atIndex: Int) -> WorldCityModel! {
        if let cityDetail : WorldCityModel = worldCitiesListResponse?.worldCitiesList[atIndex] {
            return cityDetail
        } else {
            return nil
        }
    }
    
    // function to sort worldCitiesList
    func sortWorldCitiesListBy(key : String, sortingType : GlobalConstants.SortingType) {
        if key == JsonKeyConstants.populationKey {
            if sortingType == GlobalConstants.SortingType.ascendingOrder {
                worldCitiesListResponse?.worldCitiesList = (worldCitiesListResponse?.worldCitiesList.sorted(by: { $0.population! < $1.population! }))!
            } else if sortingType == GlobalConstants.SortingType.descendingOrder{
                worldCitiesListResponse?.worldCitiesList = (worldCitiesListResponse?.worldCitiesList.sorted(by: { $0.population! > $1.population! }))!
            }
        } else if key == JsonKeyConstants.cityNameKey {
            if sortingType == GlobalConstants.SortingType.ascendingOrder {
                worldCitiesListResponse?.worldCitiesList = (worldCitiesListResponse?.worldCitiesList.sorted(by: { $0.cityName! < $1.cityName! }))!
            } else if sortingType == GlobalConstants.SortingType.descendingOrder{
                worldCitiesListResponse?.worldCitiesList = (worldCitiesListResponse?.worldCitiesList.sorted(by: { $0.cityName! > $1.cityName! }))!
            }
        }
    }
    
    // function to filter worldCitiesList by searched text
    func filterworldCitiesListBy(searchText : String!) {
         if let text = searchText, !text.isEmpty {
            worldCitiesListResponse?.worldCitiesList = (unFilteredWorldCitiesListResponse?.worldCitiesList.filter({ $0.cityName?.range(of: searchText!, options: [.caseInsensitive]) != nil }))!
         } else {
            worldCitiesListResponse = unFilteredWorldCitiesListResponse?.copy() as? WorldCitiesListResponse
         }
    }
}
