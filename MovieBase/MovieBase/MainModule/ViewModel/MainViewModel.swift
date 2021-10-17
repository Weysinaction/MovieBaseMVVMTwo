// MainViewModel.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

protocol MainViewModelProtocol {
    var filmsArray: [Film]? { get set }
    var movieAPIService: MovieAPIServiceProtocol? { get set }
    func getFilms(completion: @escaping () -> ())
}

/// MainViewModel-
class MainViewModel: MainViewModelProtocol {
    // MARK: public properties

    var filmsArray: [Film]?
    var movieAPIService: MovieAPIServiceProtocol? = MovieAPIService()
    var imageAPIService: ImageNetworkServiceProtocol? = ImageNetworkService()
    // var image

    // MARK: private properties

    private let apiURL = "https://api.themoviedb.org/3/movie/popular?api_key=23df17499c6157c62e263dc10faac033"
    private let imagePath = "https://image.tmdb.org/t/p/w500"

    func getFilms(completion: @escaping () -> ()) {
        movieAPIService?.getFilms(apiURL: apiURL, completion: { result in
            switch result {
            case let .success(films):
                self.filmsArray = films
                completion()
            case let .failure(error):
                print(error.localizedDescription)
            }
        })
    }
}
