//
//  APIModel.swift
//  MVVMDemo
//
//  Created by MANOJ SOLANKI on 10/09/21.
//

import Foundation


struct APIsList: Decodable {
    enum CodingKeys: String, CodingKey {
        case apiModels = "entries"
    }
    let apiModels : [APIModel]
}

struct APIModel: Decodable, Identifiable  {
    enum CodingKeys: String, CodingKey {
        case apiCategory = "Category"
        // Map the JSON key "url" to the Swift property name "htmlLink"
        case apiLink = "Link"
        case apiName = "API"
    }
    var id = UUID()
    let apiName : String
    let apiCategory : String
    let apiLink : String
}
