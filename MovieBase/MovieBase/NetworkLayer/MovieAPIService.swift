// MovieAPIService.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

protocol MovieAPIServiceProtocol {
    func getFilms(apiURL: String, completion: @escaping (Result<[Film]?, Error>) -> ())
}

/// MovieAPIService-
class MovieAPIService: MovieAPIServiceProtocol {
    // MARK: public methods

    func getFilms(apiURL: String, completion: @escaping (Result<[Film]?, Error>) -> ()) {
        guard let url =
            URL(string: apiURL)
        else { return }

        let session = URLSession.shared
        session.dataTask(with: url) { data, response, error in
            guard let response = response, let data = data else { return }

            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let filmRequestModel = try decoder.decode(FilmRequestModel.self, from: data)
                completion(.success(filmRequestModel.results))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
