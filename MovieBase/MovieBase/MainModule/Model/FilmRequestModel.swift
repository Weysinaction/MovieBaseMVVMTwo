// FilmRequestModel.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// FilmRequestModel-
struct FilmRequestModel: Decodable {
    let page: Int?
    let results: [Film]?
}

/// Film-
struct Film: Decodable {
    let posterPath: String?
    let overview: String?
    let originalTitle: String?
}
