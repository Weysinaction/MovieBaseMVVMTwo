// DetailViewModel.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

protocol DetailViewModelProtocol {
    var film: Film? { get set }
}

/// DetailViewModel-
class DetailViewModel: DetailViewModelProtocol {
    // MARK: public properties

    var film: Film?
}
