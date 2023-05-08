//
//  CharacterStore.swift
//  project3
//
//  Created by Stratton McDonald on 11/11/21.
//

import UIKit

enum CharacterError: Error {
    case imageCreationError
    case missingImageURL
}

class CharacterStore {
    static let AllCharacters = CharacterStore()
    
    let imageStore = ImageStore()
    
    private let session: URLSession = {
            let config = URLSessionConfiguration.default
            return URLSession(configuration: config)
        }()
    
    func fetchCharacters(completion: @escaping (Result<[Character], Error>) -> Void) {

        let url = HPAPI.HPCharactersURL
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) {
            (data, response, error) in

            let result = self.processCharactersRequest(data: data, error: error)
            OperationQueue.main.addOperation {
                completion(result)
            }
        }
        task.resume()
    }
    
    private func processCharactersRequest(data: Data?,
                                      error: Error?) -> Result<[Character], Error> {
        guard let jsonData = data else {
            return .failure(error!)
        }

        return HPAPI.characters(fromJSON: jsonData)
    }
    
    func fetchImage(for photo: Character,
                    house: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
        if house != "" {
            let photoURL = house
            let imageURL = URL(string: photoURL)
            let request = URLRequest(url: imageURL!)

            let task = session.dataTask(with: request) {
                (data, response, error) in
                let result = self.processImageRequest(data: data, error: error)
    
                OperationQueue.main.addOperation {
                    completion(result)
                }
            }
            task.resume()
        } else {
            let photoKey = photo.image
            if let image = imageStore.image(forKey: photoKey) {
                OperationQueue.main.addOperation {
                    completion(.success(image))
                }
                return
            }
        
            if photo.image == "" {
                completion(.failure(CharacterError.missingImageURL))
                return
            }
            let photoURL = photo.image
            //photoURL.insert("s", at: photoURL.index(photoURL.startIndex, offsetBy: 4))
            let imageURL = URL(string: photoURL)!
            let request = URLRequest(url: imageURL)

            let task = session.dataTask(with: request) {
                (data, response, error) in
                let result = self.processImageRequest(data: data, error: error)
            
                if case let .success(image) = result {
                    self.imageStore.setImage(image, forKey: photoKey)
                }
            
                OperationQueue.main.addOperation {
                    completion(result)
                }
            }
            task.resume()
        }
    }
    
    private func processImageRequest(data: Data?,
                                     error: Error?) -> Result<UIImage, Error> {
        guard
            let imageData = data,
            let image = UIImage(data: imageData) else {
                // Couldn't create an image
                if data == nil {
                    return .failure(error!)
                } else {
                    return .failure(CharacterError.imageCreationError)
                }
        }

        return .success(image)
    }
}


