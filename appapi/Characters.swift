//
//  Characters.swift
//  appapi
//
//  Created by Артём Сальников on 05.10.2024.
//

import Foundation
import SwiftyJSON

struct Characters {
    var name = ""
    var status = ""
    var species = ""
    var gender = ""
    var image = ""
    var location: Location?
    
    init(json: JSON) {
        if let item = json["name"].string {
            name = item
        }
        if let item = json["status"].string {
            status = item
        }
        if let item = json["species"].string {
            species = item
        }
        if let item = json["gender"].string {
            gender = item
        }
        if let item = json["image"].string {
            image = item
        }
        if let locationJSON = json["location"].dictionary {
            location = Location(json: JSON(locationJSON))
        }
    }
}

struct Location {
    var name = ""
    var url = ""
    
    init(json: JSON) {
        if let item = json["name"].string {
            name = item
        }
        if let item = json["url"].string {
            url = item
        }
    }
}


