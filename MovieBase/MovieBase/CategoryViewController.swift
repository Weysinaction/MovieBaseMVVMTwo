// CategoryViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// CategoryViewController-
final class CategoryViewController: UIViewController {
    // MARK: View elements

    private var filmTableView = UITableView()

    // MARK: private properties

    private let filmCellID = "FilmCell"
    private let apiURL = "https://api.themoviedb.org/3/movie/popular?api_key=23df17499c6157c62e263dc10faac033"
    private let imagePath = "https://image.tmdb.org/t/p/w500"
    private var filmsArray: [Film] = []

    // MARK: CategoryViewController

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViewController()
        getDataFromServer()
    }

    // MARK: Private methods

    private func setupViewController() {
        view.backgroundColor = .red
        title = "Films"

        setupTableView()
    }

    private func getDataFromServer() {
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

                DispatchQueue.main.async {
                    self.filmTableView.reloadData()
                }
            } catch {
                print(error)
            }
        }.resume()
    }

    private func setupTableView() {
        filmTableView = UITableView(frame: view.bounds, style: .plain)
        filmTableView.register(FilmTableViewCell.self, forCellReuseIdentifier: filmCellID)

        filmTableView.delegate = self
        filmTableView.dataSource = self
        view.addSubview(filmTableView)
        filmTableView.translatesAutoresizingMaskIntoConstraints = false
        filmTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        filmTableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        filmTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        filmTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

    private func configureCell(cell: FilmTableViewCell, indexPath: IndexPath) {
        let film = filmsArray[indexPath.row]

        if let title = film.originalTitle {
            cell.titleLabel.text = title
        }
        if let overview = film.overview {
            cell.descriptionLabel.text = overview
        }

        DispatchQueue.global().async {
            guard let imageURL = URL(string: "\(self.imagePath)\(film.posterPath ?? "")") else { return }
            guard let imageData = try? Data(contentsOf: imageURL) else { return }

            DispatchQueue.main.async {
                cell.imageViewFilm.image = UIImage(data: imageData)
            }
        }
    }
}

// MARK: UITableViewDelegate, UITableViewDataSource

extension CategoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filmsArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = filmTableView
            .dequeueReusableCell(withIdentifier: filmCellID, for: indexPath) as? FilmTableViewCell
        else { return UITableViewCell() }

        configureCell(cell: cell, indexPath: indexPath)

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        200
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ViewController()

        let currentItem = indexPath.row
        guard let title = filmsArray[currentItem].originalTitle,
              let overview = filmsArray[currentItem].overview,
              let imagePath = filmsArray[currentItem].posterPath else { return }
        vc.filmTitle = title
        vc.filmDescription = overview
        vc.path = imagePath
        navigationController?.pushViewController(vc, animated: true)
    }
}
