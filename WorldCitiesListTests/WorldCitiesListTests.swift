//
//  WorldCitiesListTests.swift
//  WorldCitiesListTests
//
//  Created by Ibrahim on 09/11/17.
//  Copyright © 2017 Ibrahim. All rights reserved.
//

import XCTest
import ObjectMapper
@testable import WorldCitiesList

class WorldCitiesListTests: XCTestCase {
    
    var worldCityViewModel: WorldCityViewModel!
    
    override func setUp() {
        super.setUp()
        worldCityViewModel = WorldCityViewModel()
        setWorldCitiesResponse()
    }
    
    override func tearDown() {
        super.tearDown()
        worldCityViewModel = nil
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    // function to test the getCitiesCount functionality
    func testGetCitiesCount() {
        XCTAssertEqual(worldCityViewModel.getCitiesCount(), 4, "Cities count - Not Mached")
    }
    
    // function to test the getCityDetails functionality
    func testGetCityDetails() {
        let cityModel = worldCityViewModel.getCityDetails(atIndex: 2)
        XCTAssertEqual(cityModel?.countryCode, "in", "CountryCode Not Mached")
        XCTAssertEqual(cityModel?.cityName, "coimbatore", "CityName Not Mached")
        XCTAssertEqual(cityModel?.population, 10000, "Population Not Mached")
    }
    
    // function to test the sortWorldCitiesListBy functionality
    func testSortWorldCitiesList() {
        worldCityViewModel.sortWorldCitiesListBy(key: JsonKeyConstants.populationKey, sortingType: GlobalConstants.SortingType.descendingOrder)
        let cityModel = worldCityViewModel.getCityDetails(atIndex: 0)
        XCTAssertEqual(cityModel?.countryCode, "ad", "CountryCode Not Mached")
        XCTAssertEqual(cityModel?.cityName, "aixas", "CityName Not Mached")
        XCTAssertEqual(cityModel?.population, 50101034, "Population Not Mached")
    }
    
    // function to set the worldCitiesListResponse initially from the sample JSON file
    func setWorldCitiesResponse() {
        do {
            if let file = Bundle.main.url(forResource: AppUrlConstants.unitTestSampleWorldCitiesDetailsJsonName, withExtension: AppUrlConstants.jsonExtension) {
                let data = try Data(contentsOf: file)
                let json: AnyObject? = try JSONSerialization.jsonObject(with: data, options: []) as AnyObject
                // the data will be converted to the string
                if let jsonToParse: AnyObject = json {
                    // Convert JSON String to Model
                    worldCityViewModel.worldCitiesListResponse = Mapper<WorldCitiesListResponse>().map(JSONObject: jsonToParse)!
                } else  {
                    print(ErrorMessageConstants.jsonStringConversionError)
                }
            } else {
                print(ErrorMessageConstants.fileNotExist)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
