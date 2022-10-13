//
//  Characters.swift
//  marvelComics
//
//  Created by Abduqaxxor on 12/10/22.
//

import Foundation

struct CharacterDataWrapper: Decodable{
    var code: Int?
    var status: String?
    var copyright: String?
    var attributionText: String?
    var attributionHTML: String?
    var data: CharacterDataContainer?
    var etag: String?

}

struct CharacterDataContainer: Decodable{
    var offset: Int?
    var limit: Int?
    var total: Int?
    var count: Int?
    var results: [Character]?

}

struct Character: Decodable{
    var id: Int?
    var name: String?
    var description: String?
    var modified: String?
    var resourceURI: String?
    var urls: [Url]?
    var thumbnail: Images?
    var comics: ComicList?
    var stories: StoryList?
    var events: EventList?
    var series: SeriesList?
}

struct ComicList: Decodable {
    var available: Int?
    var returned: Int?
    var collectionURI: String?
    var items: [ComicSummary]?
}

struct SeriesList: Decodable {
    var available: Int?
    var collectionURI: String?
    var items: [SeriesSummary]?
}
