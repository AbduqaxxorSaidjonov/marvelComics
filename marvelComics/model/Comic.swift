//
//  Comic.swift
//  marvelComics
//
//  Created by Abduqaxxor on 4/10/22.
//

import Foundation


 struct ComicDataWrapper: Decodable{
    var code: Int?
    var status: String?
    var copyright: String?
    var attributionText: String?
    var attributionHTML: String?
    var data: ComicDataContainer?
    var etag: String?
     
}

struct ComicDataContainer: Decodable{
    var offset: Int?
    var limit: Int?
    var total: Int?
    var count: Int?
    var results: [Comic]?
  
}

struct Comic: Identifiable, Decodable{
    var id: Int?
    var digitalId: Int?
    var title: String?
    var issueNumber: Double?
    var variantDescription: String?
    var description: String?
    var modified: String?
    var isbn: String?
    var upc: String?
    var diamondCode: String?
    var ean: String?
    var issn: String?
    var format: String?
    var pageCount: Int?
    var textObjects: [TextObject]?
    var resourceURI: String?
    var urls: [Url]?
    var series: SeriesSummary?
    var variants: [ComicSummary]?
    var collections: [ComicSummary]?
    var collectedIssues: [ComicSummary]?
    var dates: [ComicDate]?
    var prices: [ComicPrice]?
    var thumbnail: Images?
    var images: [Images]?
    var creators: CreatorList?
    var characters: CharacterList?
    var stories: StoryList?
    var events: EventList?
}

struct TextObject: Decodable{
    var type: String?
    var language: String?
    var text: String?
}

struct Url: Decodable{
    var type: String?
    var url: String?
}

struct SeriesSummary: Decodable{
    var resourceURI: String?
    var name: String?
}

struct ComicSummary: Decodable{
    var resourceURI: String?
    var name: String?
}

struct ComicDate: Decodable{
    var type: String?
    var date: String?
}

struct ComicPrice: Decodable{
    var type: String?
    var price: Float?
}

struct Images: Decodable{
    var path: String?
    var `extension`: String?
}

struct CreatorList: Decodable{
    var available: Int?
    var returned: Int?
    var collectionURI: String?
    var items: [CreatorSummary]?
}

struct CreatorSummary: Decodable{
    var resourceURI: String?
    var name: String?
    var role: String?
}

struct CharacterList: Decodable{
    var available: Int?
    var returned: Int?
    var collectionURI: String?
    var items: [CharacterSummary]?
}

struct CharacterSummary: Decodable{
    var resourceURI: String?
    var name: String?
    var role: String?
}

struct StoryList: Decodable{
    var available: Int?
    var returned: Int?
    var collectionURI: String?
    var items: [StorySummary]?
}

struct StorySummary: Decodable{
    var resourceURI: String?
    var name: String?
    var type: String?
}

struct EventList: Decodable{
    var available: Int?
    var returned: Int?
    var collectionURI: String?
    var items: [EventSummary]?
}

struct EventSummary: Decodable{
    var resourceURI: String?
    var name: String?
}
