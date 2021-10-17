// ViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit
/// Контроллер-
class ViewController: UIViewController {
    // MARK: public properties

    var viewModel: DetailViewModelProtocol!

    // MARK: private properties

    private let stackView = UIStackView()
    private let titleLabel = UILabel()
    private let headerImageView = UIImageView()
    private let descriptionLabel = UILabel()
    private let scrollView = UIScrollView()
    private var imageNetworkService: ImageNetworkServiceProtocol?
    private var imageURL = "https://image.tmdb.org/t/p/w500"

    // MARK: ViewController's methods

    override func viewDidLoad() {
        super.viewDidLoad()

        imageNetworkService = ImageNetworkService()
        setupSubviews()
        title = "Overview"
    }

    // MARK: Private methods

    private func setupSubviews() {
        view.backgroundColor = .systemBackground

        setupScrollView()
        setupTitleLabel()
        setupHeaderImageView()
        setupDescriptionLabel()
    }

    private func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(titleLabel)
        scrollView.addSubview(headerImageView)
        scrollView.addSubview(descriptionLabel)
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
    }

    private func setupTitleLabel() {
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.numberOfLines = 2
        titleLabel.text = viewModel.film?.originalTitle
        titleLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: headerImageView.topAnchor, constant: -10).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 10).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
    }

    private func setupHeaderImageView() {
        headerImageView.translatesAutoresizingMaskIntoConstraints = false
        guard let posterPath = viewModel.film?.posterPath else { return }
        imageNetworkService?.getImage(url: "\(imageURL)\(posterPath)") { result in
            switch result {
            case let .success(data):
                DispatchQueue.main.async {
                    self.headerImageView.image = UIImage(data: data)
                }
            case .failure:
                DispatchQueue.main.async {
                    self.headerImageView.image = UIImage(systemName: "xmark.shield.fill")
                }
            }
        }
        headerImageView.clipsToBounds = true
        headerImageView.layer.cornerRadius = 8
        headerImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        headerImageView.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 0.4).isActive = true
        headerImageView.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 10).isActive = true
        headerImageView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
    }

    private func setupDescriptionLabel() {
        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 15
        descriptionLabel.text = viewModel.film?.overview
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.topAnchor.constraint(equalTo: headerImageView.bottomAnchor, constant: 10).isActive = true
        descriptionLabel.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 10).isActive = true
        descriptionLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
    }
}
