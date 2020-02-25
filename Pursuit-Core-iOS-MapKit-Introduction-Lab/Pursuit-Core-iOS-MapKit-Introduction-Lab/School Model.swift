//
//  School Model.swift
//  Pursuit-Core-iOS-MapKit-Introduction-Lab
//
//  Created by Bienbenido Angeles on 2/25/20.
//  Copyright © 2020 Bienbenido Angeles. All rights reserved.
//

import Foundation
import CoreLocation

struct School: Codable {
    let schoolName: String
    let overview: String
    let apCourses: String?
    let latitude: String
    let longitude: String
    
    private enum CodingKeys: String, CodingKey{
        case schoolName = "school_name"
        case overview = "overview_paragraph"
        case apCourses = "advancedplacement_courses"
        case latitude
        case longitude
    }
}
