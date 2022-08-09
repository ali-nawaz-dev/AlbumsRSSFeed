//
//  AlbumFeedRepository.swift
//  AlbumsRSSFeed
//
//  Created by Sheikh Ali on 08/08/2022.
//

import Foundation
import RealmSwift


class AlbumFeedRepository {
    
    func getAlbums(refresh: Bool = false, completionHandler: @escaping (Result<[AlbumFeedModel], NetworkError>) -> Void) {
        if !refresh {
            
            do {
                let realm = try Realm()
                let albums = realm.objects(AlbumFeedModel.self)
                
                if albums.count > 0 {
                    completionHandler(.success(albums.toArray()))
                    fetchAlbumsFromApi(completionHandler: completionHandler)
                } else {
                    fetchAlbumsFromApi(completionHandler: completionHandler)
                }
            } catch {
                completionHandler(.failure(.returnedError(error)))
            }
        } else {
            fetchAlbumsFromApi(completionHandler: completionHandler)
        }
    }

    func getAlbum(primaryKeyValue: String, completionHandler: @escaping (Result<AlbumFeedModel, NetworkError>) -> Void) {
       
        do {
            
            let realm = try Realm()
            
            if let album = realm.object(ofType: AlbumFeedModel.self, forPrimaryKey: primaryKeyValue) {
                completionHandler(.success(album))
            } else {
                completionHandler(.failure(.dataReturnedNil))
            }
            
        } catch {
            completionHandler(.failure(.returnedError(error)))
        }
    }
    
    private func fetchAlbumsFromApi(completionHandler: @escaping (Result<[AlbumFeedModel], NetworkError>) -> Void) {
       
        guard
            let url = URL(string: APIEndPoint.feedURL)
        else {
               completionHandler(.failure(.badURL))
               return
        }
        
        let request = URLRequest(url: url)

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                let returnError = "Error in fetching albums data: \(error?.localizedDescription ?? "Unknown error")"
                completionHandler(.failure(.customError(returnError)))
                return
            }
        
            do {
                let decodedResponse = try JSONDecoder().decode(AlbumFeedApiResponseModel.self, from: data)
                if let feed = decodedResponse.feed {
                    let responseArray = Array(feed.results)
                    
                    let realm = try Realm()
                    try realm.write {
                        realm.add(responseArray, update: .modified)
                    }
                    
                    completionHandler(.success(responseArray))
                } else {
                    completionHandler(.failure(.customError("Feed is not loaded")))
                }
            }
            catch {
                print(error.localizedDescription)
                completionHandler(.failure(.returnedError(error)))
            }
        }
        .resume()
    }
    
}
