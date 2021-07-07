//
//  Application.swift
//  abm-ios
//
//  Created by Matthew Farmer on 7/6/21.
//

import Foundation

struct Application: Codable, Hashable {
    var _idFlat: String
    var title: String
    var is_featured: Bool
    var description: String
    var image_url: String
    var associated_skill_codes: [String]
    var support_status_code: String
}
