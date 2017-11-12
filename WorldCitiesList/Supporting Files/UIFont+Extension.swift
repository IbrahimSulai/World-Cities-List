//
//  UIFont+Extension.swift
//  WorldCitiesList
//
//  Created by Ibrahim on 11/12/17.
//  Copyright © 2017 Ibrahim. All rights reserved.
//

import UIKit

// MARK: - UIFont extension
extension UIFont {
    class func fontMediumWith(size: CGFloat) -> UIFont {
        return UIFont(name: "HelveticaNeue-Medium", size: size)!
    }
    
    class func fontBoldWith(size: CGFloat) -> UIFont {
        return UIFont(name: "HelveticaNeue-Bold", size: size)!
    }
    
    class func fontDemiBoldWith(size: CGFloat) -> UIFont {
        return UIFont(name: "AvenirNextCondensed-DemiBold", size: size)!
    }
}
