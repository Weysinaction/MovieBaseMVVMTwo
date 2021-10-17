// MainViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// MainViewController-
final class MainViewController: UIViewController {
    // MARK: View elements

    private var filmTableView = UITableView()
    private var viewModel: MainViewModelProtocol!
    private var imageNetworkService: ImageNetworkServiceProtocol? = ImageNetworkService()
    private let imagePath = "https://image.tmdb.org/t/p/w500"

    // MARK: private properties

    private let filmCellID = "FilmCell"

    // MARK: CategoryViewController

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViewController()
        viewModel.getFilms {
            DispatchQueue.main.async {
                self.filmTableView.reloadData()
            }
        }
    }

    // MARK: Private methods

    private func setupViewController() {
        view.backgroundColor = .red
        title = "Films"
        viewModel = MainViewModel()
        setupTableView()
    }

    private func setupTableView() {
        filmTableView = UITableView(frame: view.bounds, style: .plain)
        filmTableView.register(MainTableViewCell.self, forCellReuseIdentifier: filmCellID)

        filmTableView.delegate = self
        filmTableView.dataSource = self
        view.addSubview(filmTableView)
        filmTableView.translatesAutoresizingMaskIntoConstraints = false
        filmTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        filmTableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        filmTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        filmTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

// MARK: UITableViewDelegate, UITableViewDataSource

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.filmsArray?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = filmTableView
            .dequeueReusableCell(withIdentifier: filmCellID, for: indexPath) as? MainTableViewCell,
            let film = viewModel?.filmsArray?[indexPath.row]
        else { return UITableViewCell() }

        cell.configureCell(imagePath: imagePath, film: film, indexPath: indexPath)

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        200
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ViewController()
        let detailViewModel = DetailViewModel()
        detailViewModel.film = viewModel.filmsArray?[indexPath.row]
        vc.viewModel = detailViewModel

        navigationController?.pushViewController(vc, animated: true)
    }
}
