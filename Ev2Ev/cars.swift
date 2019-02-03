//
//  cars.swift
//  Ev2Ev
//
//  Created by Hamza Ehsan on 2/2/19.
//  Copyright © 2019 Hamza Ehsan. All rights reserved.
//

import Foundation
import MapKit
import AddressBook
import SwiftyJSON

class cars: NSObject, MKAnnotation
{
    let title: String?
    let charge: String?
    let coordinate: CLLocationCoordinate2D
    
    init(title: String?, charge: String?, coordinate: CLLocationCoordinate2D)
    {
        self.title = title
        self.charge = charge
        self.coordinate = coordinate
        
        super.init()
    }
    
    var subtitle: String? {
        return charge
    }
    
    class func from(json: JSON) -> cars?
    {
        var title: String
        if let unwrappedTitle = json["title"].string {
            title = unwrappedTitle
        }else{
            title = ""
        }
        let charge = json["charge"].string
        let lat = json["lat"].doubleValue
        let lng = json["lng"].doubleValue
        let coordinate = CLLocationCoordinate2D(latitude: lat,longitude: lng)
        
        return cars(title: title, charge: charge, coordinate: coordinate)
    }
    
    
    
}
