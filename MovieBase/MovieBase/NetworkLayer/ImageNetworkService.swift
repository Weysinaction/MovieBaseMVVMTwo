// ImageNetworkService.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

protocol ImageNetworkServiceProtocol {
    func getImage(url: String, completion: @escaping (Result<Data, Error>) -> ())
}

/// ImageAPIService-
class ImageNetworkService: ImageNetworkServiceProtocol {
    func getImage(url: String, completion: @escaping (Result<Data, Error>) -> ()) {
        guard let imageURL = URL(string: url) else { return }

        let session = URLSession.shared
        session.dataTask(with: imageURL) { data, _, error in

            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                completion(.success(data))
            }
        }.resume()
    }
}
