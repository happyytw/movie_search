//
//  ModieData.swift
//  movie
//
//  Created by Taewon Yoon on 2023/06/27.
//

import Foundation

struct Show: Codable {
    let show: ShowDetails
}

struct ShowDetails: Codable {
    let name: String
    let rating: Rating
    let summary: String?
    let image: Image
    let url: String
}

struct Rating: Codable {
    let average: Float?
}

struct Image: Codable {
    let medium: String
    let original: String
}
