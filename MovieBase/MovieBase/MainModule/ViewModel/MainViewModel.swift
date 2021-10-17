// MainViewModel.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

protocol MainViewModelProtocol {
    var filmsArray: [Film]? { get set }
    func getFilms(completion: @escaping () -> ())
    func getImage(film: Film) -> Data
}

/// MainViewModel-
class MainViewModel: MainViewModelProtocol {
    // MARK: public properties

    var filmsArray: [Film]?

    // MARK: private properties

    private let apiURL = "https://api.themoviedb.org/3/movie/popular?api_key=23df17499c6157c62e263dc10faac033"
    private let imagePath = "https://image.tmdb.org/t/p/w500"

    func getFilms(completion: @escaping () -> ()) {
        guard let url =
            URL(string: apiURL)
        else { return }

        let session = URLSession.shared
        session.dataTask(with: url) { data, response, error in
            guard let response = response, let data = data else { return }
            print(response)

            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let filmRequestModel = try decoder.decode(FilmRequestModel.self, from: data)

                guard let films = filmRequestModel.results else { return }
                self.filmsArray = films
                completion()
            } catch {
                print(error)
            }
        }.resume()
    }

    func getImage(film: Film) -> Data {
        guard let imageURL = URL(string: "\(imagePath)\(film.posterPath ?? "")"),
              let imageData = try? Data(contentsOf: imageURL) else { return Data() }

        return imageData
    }
}
