//
//  User.swift
//  Ve-scoverer
//
//  Created by Francis Adewale on 20/12/2020.
//

import UIKit
import RealmSwift
import CoreLocation


class RealmUser: Object {
    
    @objc dynamic var id = ""
    @objc dynamic var veganSince: String = ""
    @objc dynamic var firstName: String = ""
    @objc dynamic var secondName: String = ""
    @objc dynamic var age: Int = 0
    @objc dynamic var gender: String = ""
    @objc dynamic var imageURL: String = ""
    @objc dynamic var instagramLink: String = ""
    @objc dynamic var twitterLink: String = ""
    @objc dynamic var longitude: Double = 0
    @objc dynamic var latitude: Double = 0
    
    
}


