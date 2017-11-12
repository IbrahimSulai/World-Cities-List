//
//  WorldCitiesService.swift
//  WorldCitiesList
//
//  Created by Ibrahim on 10/11/17.
//  Copyright © 2017 Ibrahim. All rights reserved.
//

import Foundation
import ObjectMapper

// As of now the JSON is loaded from the local json file.
// The logic is added in the service layer because in future if the world cities list are service driven then this structure will be helpful.
class WorldCitiesService : NSObject  {
 
    func getWorldCities(delegateBlock: @escaping ((WorldCitiesListResponse) -> Void)) {
        do {
            if let file = Bundle.main.url(forResource: AppUrlConstants.worldCitiesDetailsJsonName, withExtension: AppUrlConstants.jsonExtension) {
                let data = try Data(contentsOf: file)
                let json: AnyObject? = try JSONSerialization.jsonObject(with: data, options: []) as AnyObject
                // the data will be converted to the string
                if let jsonToParse: AnyObject = json {
                    // Convert JSON String to Model
                    let worldCitiesResponse: WorldCitiesListResponse = Mapper<WorldCitiesListResponse>().map(JSONObject: jsonToParse)!
                    delegateBlock(worldCitiesResponse)
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
