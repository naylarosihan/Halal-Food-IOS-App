//
//  IslamicQuoteApiHandling.swift
//  AllThingsHalal
//
//  Created by PettaMarukka on 8/6/2024.
//

import Foundation

import Foundation

struct Hadith: Codable {
    let id: Int
    let header: String
    let hadithEnglish: String
    let narrator: String
    let book: String
    let chapter: String
    let topic: String
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case header
        case hadithEnglish = "hadith_english"
        case narrator
        case book
        case chapter
        case topic
        case url
    }
}

