//
//  AlbumFeedApiResponseModel.swift
//  AlbumsRSSFeed
//
//  Created by Sheikh Ali on 08/08/2022.
//

import Foundation
import RealmSwift

class AlbumFeedApiResponseModel: Codable {
    var feed: AlbumFeedResponseModel?
}

class AlbumFeedResponseModel: Codable {
    var title: String
    var id: String
    var author: AlbumFeedAuthorModel?
    var links: [AlbumFeedLinksModel]
    var copyright: String
    var country: String
    var icon: String
    var updated: String
    var results: [AlbumFeedModel]
}

class AlbumFeedAuthorModel: Codable {
    var name: String
    var url: String
}

class AlbumFeedLinksModel: Codable {
    var self_: String
    
    private enum CodingKeys : String, CodingKey {
        case self_ = "self"
    }
}

class AlbumFeedModel: Object, Codable {
    @Persisted var artistName: String
    @Persisted(primaryKey: true) var id: String
    @Persisted var name: String
    @Persisted var releaseDate: String
    @Persisted var kind: String
    @Persisted var artistId: String?
    @Persisted var artistUrl: String?
    @Persisted var contentAdvisoryRating: String?
    @Persisted var artworkUrl100: String
    @Persisted var genres: List<AlbumGenres>
    @Persisted var url: String
}

class AlbumGenres: EmbeddedObject, Codable {
    @Persisted var genreId: String
    @Persisted var name: String
    @Persisted var url: String
}
